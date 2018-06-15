1、pull拉取git
2、进入到dockers文件夹
`cd dockers`
3、build一个镜像
`docker build -t chensk/php5.6` .
4、执行`docker-composer up -d` 启动容器


docker-composer启动容器前，先获取redis、nginx 、mysql的镜像