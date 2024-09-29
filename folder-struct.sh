#!/bin/bash

# Create the main directory
mkdir -p RouteClouds
cd RouteClouds

# Function to create a README.md file
create_readme() {
    echo "# $1" > README.md
    echo "This is a placeholder README for the $1 repository." >> README.md
}

# Function to create a .gitignore file
create_gitignore() {
    echo "# OS generated files" > .gitignore
    echo ".DS_Store" >> .gitignore
    echo "Thumbs.db" >> .gitignore
}

# cicd-pipeline-showcase
mkdir -p cicd-pipeline-showcase/{docs,examples}
cd cicd-pipeline-showcase
create_readme "CI/CD Pipeline Showcase"
create_gitignore
touch docs/{overview.md,getting-started.md,contribution-guide.md}
touch examples/full-pipeline-demo.md
cd ..

# git-best-practices
mkdir -p git-best-practices/docs
cd git-best-practices
create_readme "Git Best Practices"
create_gitignore
touch docs/{branching-strategy.md,commit-message-guidelines.md}
cd ..

# build-tools
mkdir -p build-tools/{maven,gradle}
cd build-tools
create_readme "Build Tools"
create_gitignore
touch maven/pom.xml
touch gradle/build.gradle
cd ..

# jenkins-pipelines
mkdir jenkins-pipelines
cd jenkins-pipelines
create_readme "Jenkins Pipelines"
create_gitignore
touch Jenkinsfile
cd ..

# ansible-automation
mkdir -p ansible-automation/{playbooks,inventory}
cd ansible-automation
create_readme "Ansible Automation"
create_gitignore
touch playbooks/deploy-app.yml
touch inventory/hosts
cd ..

# docker-containerization
mkdir docker-containerization
cd docker-containerization
create_readme "Docker Containerization"
create_gitignore
touch Dockerfile
cd ..

# kubernetes-orchestration
mkdir -p kubernetes-orchestration/manifests
cd kubernetes-orchestration
create_readme "Kubernetes Orchestration"
create_gitignore
touch manifests/{deployment.yaml,service.yaml}
cd ..

# grafana-monitoring
mkdir -p grafana-monitoring/dashboards
cd grafana-monitoring
create_readme "Grafana Monitoring"
create_gitignore
touch dashboards/app-performance.json
cd ..

# elk-stack-logging
mkdir -p elk-stack-logging/{logstash,elasticsearch}
cd elk-stack-logging
create_readme "ELK Stack Logging"
create_gitignore
touch logstash/logstash.conf
touch elasticsearch/elasticsearch.yml
cd ..

# demo-application
mkdir -p demo-application/src/main/java/com/routeclouds/demo
cd demo-application
create_readme "Demo Application"
create_gitignore
touch src/main/java/com/routeclouds/demo/Application.java
touch pom.xml
touch Dockerfile
cd ..

echo "Repository structure created successfully!"