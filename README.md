promise
=======

promise/deferred mode according to pu ling

#说明：
*    该代码是在学习promise的过程中，结合朴灵的《深入浅出node.js》， 以及司徒正美前辈的博客进行promise的尝试。

#usage:
*    使用grunt进行编译。 下载后输入：
 <pre><code>
sudo npm install
</code></pre>
进行包依赖安装， 另外，要运行grunt， 还需要：
<pre><code>
sudo npm install -g grunt-cli
</pre></code>
用来运行grunt命令。
安装完依赖后， 直接运行:
<pre><code>
grunt
</code></pre>
运行结果就会出现。 目前只实现了原生模拟 和 vow的简单使用范例。

#原生:
*    文件`promise-primeval`, 使用event-emitter 事件驱动来模拟promise 和 deferred。代码参照[朴灵大大](https://github.com/JacksonTian)。
     文件`promise-vow`, 使用vow类库，进行promise的使用， 并与callback进行对比。

