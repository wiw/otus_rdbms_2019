# The empty schema of Cafe/Restaurant database in docker images

#### contains:

* cafe_db.sql
* Dockerfile
* README.MD - this RTD

## BEFORE

Do you need install docker by [official documentation](https://docs.docker.com/install/linux/docker-ce/ubuntu/)


## HOW tO RUN

Pull local this repository and from folder run command:

```
docker image build -t <image_name> .
```

Then run image:

```
docker run -p <your_free_port>:3306 --name <container_name> -d <image_name>
```

## CONNECTION

#### auth data

**user:** root

**password:** otus

**ip:** 0.0.0.0

**port:** 3306

You should change this option in `Dockerfile`


### using command line

```
mysql -uroot -p -h 0.0.0.0 -P <your_free_port>
```

### using Dbeaver

Use SetUP new `Connection` with next option:

**Server:** localhost

**Port:** <your_free_port>

**Username:** root

**Password:** otus

Then open `Driver Settings -> Connection Properties`, and add two `User Properties`


**allowPublicKeyRetrieval: true
useSSL: false**