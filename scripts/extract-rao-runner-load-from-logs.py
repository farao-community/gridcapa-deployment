#
import argparse
import re
import plotly.express as px
import pandas as pd
import logging

HELP_MESSAGE = "extract-rao-runner-load-from-logs.py -i <logs-file>"
TIMESTAMP_REGEX = "\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}.\d{3}"
RAO_REQUEST_RECEIVED = "RAO request received"
RAO_RESPONSE_SENT = "RAO response sent"
RAO_REQUEST_REGEXP = f"({RAO_REQUEST_RECEIVED}|{RAO_RESPONSE_SENT})"
PROCESS_LIST = ["CSE/IMPORT/D2CC",
                "CSE/IMPORT/IDCC",
                "CSE/EXPORT/D2CC",
                "CSE/EXPORT/IDCC",
                "SWE/D2CC",
                "SWE/IDCC",
                "SWE/IDCC_IDCF",
                "CSE/IMPORT_EC/IDCC",
                "CSE/IMPORT_EC/D2CC",
                "CORE/CC"]
PROCESS_REGEXP = f"({'|'.join(PROCESS_LIST)})"
LOG_REGEX = re.compile(f"\[pod/(?P<pod>.*)/rao-runner].*(?P<timestamp>{TIMESTAMP_REGEX}).*(?P<type>{RAO_REQUEST_REGEXP}).*(?P<process>{PROCESS_REGEXP}).*")


def extract_tasks_from_logs_file(logs_file):
    tasks_started = {}
    tasks_finished = []
    for line in logs_file:
        result = LOG_REGEX.match(line)
        if not result:
            logging.info(f"Line '{line}' does not match regex")
            continue

        event_type, pod, process, timestamp = extract_log_event_info(result)
        if event_type == RAO_REQUEST_RECEIVED:
            tasks_started[pod] = dict(Pod=pod, Start=timestamp, Process=process)
        elif event_type == RAO_RESPONSE_SENT and pod in tasks_started:
            task = tasks_started.pop(pod)
            task["Finish"] = timestamp
            tasks_finished.append(task)
        else:
            logging.info(f"Line '{line}' pod does first finish a previous task. Ignored.")
    for pod, task in tasks_started.items():
        logging.error(f"Pod {pod} started task for process {task['Process']} at {task['Start']} but did not finish.")
    return tasks_finished


def extract_log_event_info(result):
    pod = result.group("pod")
    timestamp = result.group("timestamp")
    event_type = result.group("type")
    process = result.group("process")
    return event_type, pod, process, timestamp


def show_tasks_diagram(tasks_to_show):
    if not tasks_to_show:
        logging.error("No task finished in input data. Cannot draw graph.")
    else:
        df = pd.DataFrame(tasks_to_show)
        fig = px.timeline(df, x_start="Start", x_end="Finish", y="Pod", color="Process")
        fig.show()


def parse_args():
    arg_parser = argparse.ArgumentParser()
    arg_parser.add_argument("-i", "--input", help="Kubernetes log file for rao-runner pods", required=True)
    args = arg_parser.parse_args()
    input_log_file = args.input
    logging.info(f"Input logs file is '{input_log_file}'")
    return input_log_file


if __name__ == '__main__':
    input_log_file = parse_args()
    file = open(input_log_file, "r")
    all_tasks = extract_tasks_from_logs_file(file)
    show_tasks_diagram(all_tasks)
