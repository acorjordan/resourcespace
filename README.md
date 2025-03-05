This is taken from the [Official ResourceSpace Docker Repository](https://github.com/resourcespace/docker) and has been iterated on. The main changes are:
- The Dockerfile has been modified to reduce the number of RUN commands.
- Github Actions have been added to automate the build process.

# resourcespace/docker
The official Docker image for ResourceSpace. Full build instructions can be found on our [Knowledge Base](https://www.resourcespace.com/knowledge-base/systemadmin/install_docker).

# Installation notes
* Before building the Docker image, change the db.env file replacing the default "change-me" passwords to secure values.
* When setting up ResourceSpace ensure you enter "mariadb" as the MySQL server instead of "localhost" and leave the "MySQL binary path" empty.
