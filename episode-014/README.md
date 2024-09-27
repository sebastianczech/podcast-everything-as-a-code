# Odcinek 14 - Jak wykonac diagram za pomoca kodu ?

Materiały:
- 

Narzędzia:
- [diagrams as a code](https://diagrams.mingrammer.com/)
- [PlantUML](https://plantuml.com/)
- [Mermaid](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams)
- [Structurizr](https://www.structurizr.com/)
- [Graphviz](https://graphviz.org/)

Przykład:

1. [Diagram do repozytorium kodu dotyczącego AWS serverless REST API](https://github.com/sebastianczech/aws-serverless-rest-api) utworzony za pomocą komend:

```bash
cd design

python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

python architecture_diagram.py
```

[Sam kod źródłowy jest dosyć krótki i łatwy do zrozumienia](https://github.com/sebastianczech/aws-serverless-rest-api/blob/main/design/architecture_diagram.py):

```python
from diagrams import Cluster, Diagram
from diagrams.generic.device import Tablet
from diagrams.aws.compute import Lambda
from diagrams.aws.integration import SQS, SNS
from diagrams.aws.storage import S3
from diagrams.aws.management import Cloudwatch
from diagrams.aws.database import Dynamodb
from diagrams.programming.language import Python

with Diagram("Architecture diagram", show=False, direction="LR"):
    user = Tablet("end user's web browser")

    with Cluster("AWS"):
        lambda_producer = Lambda("producer API")
        lambda_consumer = Lambda("consumer API")
        sqs_queue = SQS("message queue")
        dynamo_database = Dynamodb("database")
        sns_notifications = SNS("notification topic")
        cloud_watch_logs = Cloudwatch("logs")

    with Cluster("Localstack"):
        python_app = Python("boto3 client")
        local_sqs_queue = SQS("message queue")
        local_s3_storage = S3("object storage")
        local_sns_notifications = SNS("notification topic")
        local_dynamo_database = Dynamodb("database")

    user >> lambda_producer >> sqs_queue >> lambda_consumer
    lambda_consumer >> dynamo_database
    lambda_consumer >> sns_notifications
    lambda_producer >> cloud_watch_logs
    lambda_consumer >> cloud_watch_logs

    user >> python_app 
    python_app >> local_sqs_queue
    python_app >> local_dynamo_database
    python_app >> local_sns_notifications
    python_app >> local_s3_storage
```

2. [Kolejny przykład mojego diagramu stworzonego dla chmury Oracle Cloud Infrastructure](https://github.com/sebastianczech/iac-tld-devops)
3. [Następny diagram dla chmury Oracle, tym razem dla rozwiązania z Kubernetes](https://github.com/sebastianczech/k8s-oci)
4. [Kolejny mój diagram dla rozwiązań Cloud Native](https://github.com/sebastianczech/Cloud-Native-CI-CD)
5. [Następny mój diagram, tym razem z plantUML](https://github.com/sebastianczech/Learning-CI-CD)

```
@startuml Basic Sample
!includeurl https://raw.githubusercontent.com/RicardoNiepel/C4-PlantUML/release/1-0/C4_Container.puml

Person(devops, "DevOps Engineer")
Person(developer, "Software Engineer")

System_Boundary(cicd, "CI/CD") {
    Container(gitlab, "GitLab", "Git, WWW, database", "Source code version control platform")
    Container(jenkins, "Jenkins", "Pipelines", "CI/CD platform")
    Container(repo_nexus, "Nexus Repository", "Software component management")
    Container(repo_jfrog, "JFrog Artifactory", "Repository manager")
    Container(test_sonar, "SonarQube", "Code quality and security")
    Container(test_robot, "Robot Framework", "Acceptance testing")
    Container(ansible, "Ansible", "Application deployment and configuration management")
    Container(docker_registry, "Docker Registry", "Docker images repository")
}

System_Ext(dev_machine, "IDE", "e.g. IntelliJ IDEA, PyCharm")
System_Ext(k3s, "K3s", "Lightweight Kubernetes")
System_Ext(docker_compose, "Docker Compose", "Tool for running multi-container application")

Rel(developer, dev_machine, "Develops code")
Rel(devops, gitlab, "Manages", "HTTPS")

Rel(dev_machine, gitlab, "Commits / pushes", "Git (HTTPS)")
Rel(gitlab, jenkins, "Notifies", "HTTPS")
Rel(jenkins, repo_nexus, "Store built packages", "HTTPS")
Rel(jenkins, repo_jfrog, "Store built packages", "HTTPS")
Rel(jenkins, test_robot, "Acceptance tests", "HTTPS")
Rel(jenkins, test_sonar, "Code quality and security tests", "HTTPS")
Rel(jenkins, ansible, "Deploy application", "HTTPS")
Rel(jenkins, docker_registry, "Store built images", "HTTPS")
Rel(ansible, k3s, "Deploy on Kubernetes", "SSH")
Rel(ansible, docker_compose, "Deployn on Docker Compose", "SSH")

@enduml
```

6. Przykład użycia `Mermaid`

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```