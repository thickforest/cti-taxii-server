#1. 使用docker构建一个 taxii2.0 server
` cd cti-taxii-server `

构建docker镜像

` docker build -t taxii2 . `

` docker images `

> REPOSITORY                 TAG                 IMAGE ID            CREATED             SIZE
>
> taxii2                     latest              11c3e9a5044a        9 minutes ago       757MB

启动一个docker容器

`docker run -d -p 9000:9000 --name taxii2.0 taxii2.0:latest`

`docker ps `

> CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                    NAMES
>
>8912826eea53        taxii2              "supervisord -c /s..."   14 minutes ago      Up 14 minutes       0.0.0.0:9000->9000/tcp   taxii2

#2. taxii2.0 client 安装与测试

安装

`cd cti-taxii-client`

`python setup.py install`

测试

`ipython`

`>>> from taxii2client import Server`

`>>> server = Server('http://localhost:9000/taxii/', 'admin', '123456') `

`>>> server.title`
> u'Some TAXII Server'

`>>> api_root = server.api_roots[2] `

`>>> api_root.url`
> u'http://localhost:9000/trustgroup1/'

`>>> collection = api_root.collecitons[0]`

`>>> objects = collection.get_objects()`

`>>> import json `

`>>> print json.dumps(objects, indent=2)`

```
{
  "type": "bundle",
  "objects": [
    {
      "name": "Poison Ivy",
      "created": "2017-01-27T13:49:53.997Z",
      "labels": [
        "remote-access-trojan"
      ],
      "modified": "2017-01-27T13:49:53.997Z",
      "type": "malware",
      "id": "malware--fdd60b30-b67c-11e3-b0b9-f01faf20d111",
      "description": "Poison Ivy"
    },
    {
      "valid_from": "2014-05-08T09:00:00.000000Z",
      "name": "File hash for Poison Ivy variant",
      "created": "2014-05-08T09:00:00.000Z",
      "pattern": "[file:hashes.'SHA-256' = 'ef537f25c895bfa782526529a9b63d97aa631564d5d789c2b765448c8635fb6c']",
      "labels": [
        "file-hash-watchlist"
      ],
      "modified": "2014-05-08T09:00:00.000Z",
      "type": "indicator",
      "id": "indicator--a932fcc6-e032-176c-126f-cb970a5a1ade"
    },
    {
      "created": "2014-05-08T09:00:00.000Z",
      "modified": "2014-05-08T09:00:00.000Z",
      "target_ref": "malware--fdd60b30-b67c-11e3-b0b9-f01faf20d111",
      "relationship_type": "indicates",
      "type": "relationship",
      "id": "relationship--2f9a9aa9-108a-4333-83e2-4fb25add0463",
      "source_ref": "indicator--a932fcc6-e032-176c-126f-cb970a5a1ade"
    }
  ],
  "spec_version": "2.0",
  "id": "bundle--2c4051a3-4650-47cc-addd-a8fd1e9966e2"
}
```

将输出放到 https://oasis-open.github.io/cti-stix-visualization/ 可以将关系可视化输出
