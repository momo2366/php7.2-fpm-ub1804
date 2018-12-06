# 基于 ubuntu 18.04 制作的php7.2-fpm镜像

- 包含了一些常用模块
如

```
	exif 读取图片
	yac php缓存
	fileinfo 获取文件mime
	opcache php加速
	apcu 脚本缓存
	imagemagick 图形库
	imap 邮件
```

- 工作目录
```
	/var/www/html
```

- php配置目录
```
	/etc/php/7.2/fpm/conf.d/ 
```

# 获取镜像
```
	docker pull momo2366/php7.2-fpm-ub1804
```

# 使用
```
	docker run -d --restart always --name php7.2-fpm-ub1804 -p 9000:9000 -v /YOURWORKDIR:/var/www/html -v /YOURCONFDIR:/etc/php/7.2/fpm/conf.d/ momo2366/php7.2-fpm-ub1804
```
