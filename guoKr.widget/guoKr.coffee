command: "python guoKr.widget/guoKr.py"

refreshFrequency: "1h"
style : """
	top: 20px
	left: 20px
	margin: 0px
	padding: 0px
	font-family:'微软雅黑'

	a
		color:#fff
		text-decoration:none

	#container
		width: 340px
		height:500px
		background: rgba(0,0,0,0.5)
		border-radius: 10px
		color:#fff
		font-size:20px
		padding:5px

	#container_title
		height:40px
		line-height:40px
		text-align:center
	#window
		height:450px
		overflow-y:auto

	#container ul
		padding:0px

	#container ul li
		list-style:none
		background:rgba(100,100,100,0.8)
		border-radius:5px
		margin:10px 0px
		border:solid 1px #efefef
	
	.article
		border-radius:5px
		padding:5px

	.article-info

	.title
		font-size:20px
		font-family:'微软雅黑'

	.author-time
		font-size: 15px
		margin-top:10px
	.article-img
		margin:10px auto
	
	.describe
		font-size:15px

	#buttons
		width: 340x
		background: rgba(0,0,0,0.5)
		border-radius: 10px
		color:#fff
		font-size:20px
		padding:5px
		margin-top:20px
		border:solid 1px #efefef
		overflow-x:hidden

	
"""
myFunction :(parse) ->
		JSON.parse(parse)
getInsideStr : (output) ->
	str = ""
	for i in output
		str += """
			<li>
				<a href="#{i['url']}">
					<div class="article">
						<div class="article-info">
							<div class="title">
								#{i['title']}
							</div>
							<div class="author-time">
								<span style='color:#46b6b6;'>
									#{i['author']}
								</span>
								|
								<span>
									#{i['time']}
								</span>
							</div>
						</div>
						<div class="article-img">
							<img src="#{i['img']}" width="330" alt="">
							
						</div>
						<div class="describe">
							#{i['describe']}
						</div>
					</div>
				</a>
			</li>
		"""
	str
render:  (output) ->
	output = @myFunction(output)
	str = @getInsideStr(output)
	"""
		<link rel="stylesheet" href="//res.layui.com/layui/dist/css/layui.css?t=1515376178738">
		<script src="//res.layui.com/layui/dist/layui.js?t=1515376178738"></script>
		<div id ="container">
			<div id="container_title">
				果壳-热点
			</div>
			<div id="window">
				<ul>
					#{str}
				</ul>
			</div>
		</div>
		<div id="buttons">
			<div class="layui-btn-container" style="height:30px">
				<button class="layui-btn layui-btn-sm" data="hot">热点</button>
				<button class="layui-btn layui-btn-sm" data="frontier">前沿</button>
				<button class="layui-btn layui-btn-sm" data="viewpoint">观点</button>
				<button class="layui-btn layui-btn-sm" data="biology">生物</button>
				<button class="layui-btn layui-btn-sm" data="psychology">心理</button>
				<button class="layui-btn layui-btn-sm" data="internet">互联网</button>
			</div>
		</div>
	"""

update: (output, domEl) ->
	output = @myFunction(output)
	str = @getInsideStr(output)
	$('#window ul').html(str)
	$('button').on 'click', (event)=>
		console.log($(event.target).attr('data'))
		@command = "python guoKr.widget/guoKr.py "+$(event.target).attr('data')
		@refresh()
		$('#container_title').html("果壳-"+$(event.target).html())


	 

 