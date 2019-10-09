#!/usr/bin/env bash
image_version=`date +%Y%m%d%H%M`;
# 构建vue/test:$image_version镜像
docker build -t vue/test:$image_version .;
# 查看镜像列表
docker images;
# 关闭vue_test容器
docker stop vue_test || true;
# 删除vue_test容器
docker rm vue_test || true;
# 基于vue/test 镜像 构建一个容器 vue_test
docker run -p 8081:80 -d --name vue_test vue/test:$image_version;
# 查看日志
docker logs vue_test;
#删除build过程中产生的镜像    #docker image prune -a -f
docker rmi $(docker images -f "dangling=true" -q);
# 删除vue/test镜像
docker rmi --force $(docker images | grep vue/test | awk '{print $3}');
# 对空间进行自动清理
docker system prune -a -f;
