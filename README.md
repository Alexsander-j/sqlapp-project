# Introduction

Here, an app will interact with tables with an MsSql database, and query it to show a web page with the table.

![](https://github.com/nokorinotsubasa/sqlapp-project/blob/67ee50b744618708649f5cae0c5db5b26ec72041/images/Architecture.png)

>`Architecture`

The app is an ASP.Net running in C#

All the resources will be deployed with Terraform.

The app will be build with Jenkins, which will be used as CI for an Azure DevOps environment.

## Before we start

- To see how to integrate Jenkins and Azure for Continuous Integration, [click here](https://github.com/nokorinotsubasa/CI-jenkins-azure)

- To see how to use docker containers as Jenkins agents, [click here](https://github.com/nokorinotsubasa/jenkins-docker-agent)


### Steps

- First, let's run `terraform` to deploy all the resources we need; the Virtual machines will run script extensions upon creation, to speed up the process;

- The Jenkins agent Vm will `already be configured` to spin docker containers, thanks to the script extension implementation;

- Procede with jenkins configuration, create an admin user, download `Docker`, `github` and `azure cli` plugins;

![]()

>you can get the initial password with: `sudo docker logs jenkins`

- Set up `GitHub connection` on Jenkins for code checkout, to do this:

In the Vm, generate ssh keys:

>`ssh-keygen -t rsa`

The public key goes into the github settings; the private key into the jenkins credentials settings;

you need to add it into the `known_hosts_file`, to do this:

>`ssh github-key-temp >> ~/.ssh/known_hosts`

>`ssh-keyscan github.com >> ~/.ssh/known_hosts`

Don't forget to start the ssh agent:

>`eval ssh-agent`

- Set up docker `cloud provider` on Jenkins, for the container agents. Remember to correctly set the agent Vm IP;

- Create a new Job on Jenkins of type pipeline, set the source code as: `Source code from scm` and set github ssh credentials and connection.

- Now, follow [this link](https://github.com/nokorinotsubasa/CI-jenkins-azure) to integrate Jenkins into Azure;

- Now on Azure, with Jenkins and GitHub service connection, create a new Pipeline, select `Pipeline template`;

- Search and select `Jenkins`;

- Correctly set the required fields, `REMEMBER THAT THE JOB NAME IS THE EXACTLY JOB NAME OF THE JENKINS JOB`;

- Create a `Release Pipeline` on azure, and select the Azure web app job, insert the app service type, name and framework;

- Configure the artifact source, in our case: `build`;

- Activate the `Continuous Delivery` trigger;

- Head back into `Pipelines` and set the `Continuous Integration` trigger (GitHub commit)

- Now, upon running the Pipeline, it will queue the Jenkins job, building the app and generating the `artifact`, this will be downloaded into the build pipeline on Azure DevOps, to be later used;

- The Release Pipeline will start running, this will download the artifact from the build, and deploy the app into our `Azure App Service`.



### Final result

- Now, when accessing the web page, you will get a list of products; On every approved commit, a pipeline will run, building and deploying a new version of the app, thanks to CI/CD integration.

![]()

>`app's web page`

### Persist Jenkins data

- To Persist Jenkins data, [click here](https://github.com/nokorinotsubasa/tar-jenkins-docker)