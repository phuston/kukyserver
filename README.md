# kukyserver

**Created by Patrick Huston, Hieu Nguyen, Keenan Zucker, and Franton Lin**

**Fall 2015**

Kuky is the world's first anonymous poetry sharing application. Think Yik-Yak, but every post has to be Haiku.

This is the REST backend we developed to work with our Kuky android application; it is written using the NodeJS framework. We use Sequelize to map MariaDB data to Javascript models that we can process, node-crypto to hash passwords, and PassportJS to authenticate incoming requests.

The production version of our backend runs on a server on Ubuntu 14.04. We implemented git hooks to forward all commits to master to our production server.

To learn more, contact patrick.huston@students.olin.edu
