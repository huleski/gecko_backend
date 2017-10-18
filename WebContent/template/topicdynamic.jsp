<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:forEach items="${set }" var="a">
		<!-- 加载的是回答 -->
		<c:if test="${a.mark == 1 }">
			<div class="text-block">
				<div class="question">
					<a href="${pageContext.request.contextPath}/questionServlet?method=findById&id=${a.question.id}">
						${fn:substring(a.question.title, 0, 50) }...
					</a>
				</div>
				<div style="position: relative;">
					<button class="thinking">${a.agreeCount }</button>
					<span class="author-info"> 
						<a href="${pageContext.request.contextPath}/userServlet?method=findById&id=${a.user.id}" class="author-name">
							${a.user.name }
						</a>
						<span class="author-signal">, ${a.user.sentence }</span>
					</span>
				</div>
				<div class="text">
					<span class="word">${fn:substring(a.pureContent, 0, 300) }...</span> <span class="showall">显示全部</span>
				</div>
				<div class="text-all">${a.content }</div>
				<div class="text-footer">
					<a href="#">关注问题</a> 
					<a class="text-comment" href="javascript:void(0)" onclick="showComment(${a.id}, 1, 1, this)">${a.commentCount } 条评论</a> 
					<span class="hidelabel">
						<a href="#">感谢</a> 
						<a href="#">分享</a> 
						<a href="#">收藏</a> 
						<a href="#">没有帮助</a>
						<a href="#">举报</a>
					</span> 
					<a href="#">作者保留权利</a> 
					<span class="takebackspan"><a>收起</a></span>
				</div>
				
				<!-- 评论div -->
				<div class="commentdiv">
					<!-- 用户评论 -->
					<div class="user-commentblock">
					</div>
					<div class="separator"></div>
					<!--评论回答-->
					<div>
						<input type="text" class="form-control commentInput" placeholder="写下你的评论"/>
						<button class="btn btn-info commentSubmitBtn" disabled="disabled" type="button" onclick="submitAnswerComment(this, null, ${a.id}, 1)">评论</button>
					</div>
				</div>
				<div class="separator"></div>
			</div>
		</c:if>
	
		<!-- 加载的是文章 -->
		<c:if test="${a.mark == 2 }">
			<div class="text-block">
				<div class="question">
					<a href="${pageContext.request.contextPath}/articleServlet?method=findById&aid=${a.id}">
						${fn:substring(a.title, 0, 50) }...
					</a>
				</div>
				<div style="position: relative;">
					<button class="thinking">${a.agreeCount}</button>
					<span class="author-info"> 
						<a href="${pageContext.request.contextPath}/userServlet?method=findById&id=${a.user.id}" class="author-name">
							${a.user.name }
						</a>
						<span class="author-signal">, ${a.user.sentence }</span>
					</span>
				</div>
				<div class="text">
					<img alt="titlePic" width="200px" height="120px" src="${pageContext.request.contextPath}/${a.titlePicture}">
					<span class="word">${fn:substring(a.pureContent, 0, 300) }...</span> <span class="showall">显示全部</span>
				</div>
				<div class="text-all">${a.content }</div>
				<div class="text-footer">
					<a href="#">关注问题</a> 
					<a class="text-comment" href="javascript:void(0)" onclick="showComment(${a.id}, 1, 2, this)">${a.commentCount } 条评论</a> 
					<span class="hidelabel">
						<a href="#">感谢</a> 
						<a href="#">分享</a> 
						<a href="#">收藏</a> 
						<a href="#">没有帮助</a>
						<a href="#">举报</a>
					</span> 
					<a href="#">作者保留权利</a> 
					<span class="takebackspan"><a>收起</a></span>
				</div>
				
				<!-- 评论div -->
				<div class="commentdiv">
					<!-- 用户评论 -->
					<div class="user-commentblock">
					</div>
					<div class="separator"></div>
					<!--评论回答-->
					<div>
						<input type="text" class="form-control commentInput" placeholder="写下你的评论"/>
						<button class="btn btn-info commentSubmitBtn" disabled="disabled" type="button" onclick="submitAnswerComment(this, null, ${a.id}, 2)">评论</button>
					</div>
				</div>
				<div class="separator"></div>
			</div>
		</c:if>
	</c:forEach>
	

	<div class="text-block">
		<div class="question">
			<a href="${pageContext.request.contextPath}/questionServlet?method=findById&id=22">
				如何看待ti7之后存在一些wings清流粉无脑吹wings并且贬低其他队伍的现象？
			</a>
		</div>
		<div style="position: relative;">
			<button class="thinking">839</button>
			<span class="author-info"> <a href="#" class="author-name">郭哲彪</a>
				<span class="author-signal">, 逗比的泪窦久泽可乐喝了</span>
			</span>
		</div>
		<div class="text">
			<span class="word">TI7的评论席上，国土说WINGS是一个前无古人的战队，刷新了职业战队对于BP的理念。即使那些所谓的灵性外国队，例如液体也只是在后期弄出个先知体系的大招。但wings
				的感觉是场场都有大招。也许大家都记得wings打MVP放对面PA的大招，用了2套阵容打爆MVP，杀人诛心。但其实第二局的阵容选了 蝙蝠
				虚空 JUGG，原本人们都以为会是虚空 1号位 jugg 2号位 蝙蝠三号位（他们当时常用的英雄）。结果是 JUGG 1号位 虚空3
				号位 蝙蝠2号位。不能说…</span> <span class="showall">显示全部</span>
		</div>
		<div class="text-all">
			<p>TI7的评论席上，国土说WINGS是一个前无古人的战队，刷新了职业战队对于BP的理念。即使那些所谓的灵性外国队，例如液体也只是在后期弄出个先知体系的大招。但wings
				的感觉是场场都有大招。</p>
			<p>也许大家都记得wings打MVP放对面PA的大招，用了2套阵容打爆MVP，杀人诛心。但其实第二局的阵容选了 蝙蝠 虚空
				JUGG，原本人们都以为会是虚空 1号位 jugg 2号位 蝙蝠三号位（他们当时常用的英雄）。结果是 JUGG 1号位 虚空3 号位
				蝙蝠2号位。不能说这个分路的效果有多大，今年TI7 哪个战队敢这么换着玩。</p>
			<p>还有WINGS锤爆 EG的两场，1手拉比克 后面连点 抄袭 和谜团。第二局自己ban了戴泽
				拿神灵（所有人都以为他们要拿小黑）。领先一分的时候选个TF炸弹的花活，落后一分的时候保持自己的阵容 SK 大鱼
				虚空（这场对面选了小娜迦），所有人都在担心小娜迦是大哥，要是TI7 lgd 和NB 的尿性 选完虚空 肯定要补 克制娜迦的 阵容。</p>
			<p>所有人都看不懂WINGS的阵容，但他们总是能赢 而且还赢的漂亮。TI6 版本英雄 POM GA. 总决赛pom我放你3场，
				GA体系， 在我这就没赢过。国外队得ban我的小精灵，我也能玩小精灵。有蝙蝠 以后 最后一手敢补斧王的 队伍，敢让斧王打一号位的队伍。
			</p>
			<p>总决赛1-0落后的 卡尔被单杀， 虚空开大被 娜迦破解的时候，经济差8K 了。按照 lgd 和NB 的尿性 1号位和3号位
				就要开始怂了，应该不知道 怎么接技能了，3号位 要发呆了。我当时躺着床上 手抓着床单 心跳120.结果WINGS 一波
				打回来了，上高了， 对面GG 了，。</p>
			<p>第4局 对面四核 都肥，小鱼 伐木机 POM 夜魔，2塔没破 小鱼 都到 高低杀人了。按照TI7 lgd 和NB 的尿性
				应该是开着 BKB 懵逼 或者 OB 人家拆高 然后跳上去送一波 GG。但wings 是 听说 你有夜魔 听说夜魔有A仗 听说是晚上
				听说我落后 15k的经济 ，听说 OB那群burden 说让我晚上怂 白天凶。不好意思 0换3 带盾 扫你外塔。</p>
			<p>听说你PA 不到20分钟 暗灭 带盾 还有双倍。 按照按照TI7 lgd 和NB 的尿性
				应该是怂在高低，大哥去刷安全的线，酱油挨个送。不好意思 0换6.</p>
			<p>wings 是那个所有人都在感叹 还能这么玩啊的队，是那个在任何劣势都有可能翻盘的队，是那个敢在TI上选炸弹 TF的队 。
				他就像是围棋届的 阿尔法狗一样打破了我们原有对于BP 所有陈旧的认识。</p>
			<p>我和我的老伙伴们多想在 这个夏天的末尾再次 听到 龙弟弟说 ：“ig/NB/LFY/lgd你们准备好了嘛？！”</p>
			<p>再次 听到 胖头鱼说 有深意的说道：奇数年？！ 奶子D激情的 呐喊 ： 炸了 炸了 。生日宝说：这不尊重一下？ DC
				呵斥单车：你干什么呀？ 还没破路呢。</p>
			<p>MLGB</p>
			<p>GTMD ACE</p>
			<p></p>
			<p></p>
			<p></p>
		</div>
		<div class="text-footer">
			<a href="#">关注问题</a> 
			<a class="text-comment" href="javascript:void(0)" onclick="showComment(1, 1, 1, this)">463 条评论</a> 
			<span class="hidelabel">
				<a href="#">感谢</a> 
				<a href="#">分享</a> 
				<a href="#">收藏</a> 
				<a href="#">没有帮助</a>
				<a href="#">举报</a>
			</span> 
			<a href="#">作者保留权利</a> 
			<span class="takebackspan"><a>收起</a></span>
		</div>
		
		
		<!-- 评论div -->
		<div class="commentdiv">
			<!-- 用户评论 -->
			<div class="user-commentblock">
				<div class="user-comment"></div>
				<div class="separator"></div>
				
				<!-- 分页 -->
				<div style="padding:10px 0;text-align: center;">
					<ul class="pagination" style="margin:auto">
						<!-- 上一页 -->
					  	<li class="disabled"><a href="javascript:void(0)">&laquo;</a></li>
						
						<!-- 翻页数 -->
					  	<li class="active" style="z-index:3"><a href="javascript:void(0)">1</a></li>
					  	<li style="z-index:3"><a href="javascript:void(0)">2</a></li>
					  	<li style="z-index:3"><a href="javascript:void(0)">3</a></li>
								
						<!-- 下一页 -->
					  <li><a href="javascript:void(0)" onclick="showComment(1, 2, this)">&raquo;</a></li>
					</ul>		
				</div>
			</div>
			<div class="separator"></div>
			<!--评论回答-->
			<div>
				<input type="text" class="form-control commentInput" placeholder="写下你的评论"/>
				<button class="btn btn-info commentSubmitBtn" disabled="disabled" type="button" onclick="submitAnswerComment(this, null, ${a.id})">评论</button>
			</div>
		</div>
		<div class="separator"></div>
	</div>

	<div class="text-block">
		<div class="question">
			<a href="${pageContext.request.contextPath}/jsp/answer2.jsp">关于人性，你最想讲的一个故事是什么？</a>
		</div>
		<div style="position: relative;">
			<button class="thinking">5323</button>
			<span class="author-info"> <a href="#" class="author-name">张佳玮</a>
				<span class="author-signal">, <a href="#">文学话题优秀回答者</a>
					公众号：张佳玮写字的地方
			</span>
			</span>
		</div>
		<div class="text">
			<img class="graphics" src="${pageContext.request.contextPath}/" /> <span
				class="word">谢邀。
				十年前吧，我在某网站写了篇游戏文字，虚构了一段贫困的生活。熟我的诸位知道我在开玩笑，在下面跟帖，嬉笑打闹。
				有一位仁兄，认认真真地长篇回帖，大概意思：“看来现实生活果然与网络不同啊，在网络上风光的人现实生活未必如意……哎接下来中国互…</span> <span
				class="showall">显示全部</span>
		</div>
		<div class="text-all">
			<p>谢邀。</p>
			<p>
				<br>
			</p>
			<p>
				<br>
			</p>
			<p>十年前吧，我在某网站写了篇游戏文字，虚构了一段贫困的生活。</p>
			<p>熟我的诸位知道我在开玩笑，在下面跟帖，嬉笑打闹。</p>
			<p>
				<br>
			</p>
			<p>有一位仁兄，认认真真地长篇回帖，大概意思：</p>
			<p>“看来现实生活果然与网络不同啊，在网络上风光的人现实生活未必如意……哎接下来中国互联网会日渐式微，张佳玮这样不肯跟传统圈子打好关系的人，会越来越艰难吧……看了张佳玮的许多文字，早就猜到他实际上生活中会这样了……还是先把自己的生活水平提高点吧，毕竟虚拟世界都是假的……”</p>
			<p>
				<br>
			</p>
			<p>这个回帖理所当然遭到了大家的围观和嘻嘻哈哈。我始终没说话。这且罢了。</p>
			<p>之后，这位仁兄给我发了网站私信。大意是：</p>
			<p>“哈哈哈哈好尴尬呀，我只想着自己想表达的意思了，就没仔细看你的文。”</p>
			<p>“哎其实我之前看你的文时，以为你年纪比我大，知道你比我小之后，有点不爽，所以说了这些话，这也算是文人相轻吧哈哈哈哈。”</p>
			<p>
				<br>
			</p>
			<p>我觉得他话里话外透出的意思，很微妙：</p>
			<p>
				——他因为不喜欢我，所以，<b>很希望</b>我过得不顺。
			</p>
			<p>
				——当他发现我疑似有不顺的可能时，<b>就相信</b>我真的过得不顺，赶紧出来评点一番。
			</p>
			<p>
				——当他发现评点错误时，又跟我长篇解释；其实我对他的看法，对他并不重要，他自己解释为“文人相轻”，似乎更像是，<b>给自己找个台阶下</b>。
			</p>
			<p>
				<br>
			</p>
			<p>我对这种心态很有兴趣。之后某篇文里，完全匿名，也没有引用原句，只是讲了遍这个故事。</p>
			<p>结果讲完后，这位仁兄又给我发私信。对我大肆辱骂一番。还说一定不会放过我的——虽然我文里还特意遮掉了他的名字，也没有摘引原话，但似乎对他而言，单是提及这件事，就是对他的绝大侮辱了。</p>
			<p>
				<br>
			</p>
			<p>
				<br>
			</p>
			<p>我通过这个案例，明白了人性一些微妙所在。</p>
			<p>一个人，可能因为各种莫名其妙的原因，仇视另一个人。这很正常。</p>
			<p>
				这种仇视会使他丧失中立与客观，一门心思希望他过得不好。即所谓，<b>“人只肯相信自己愿意相信的”。</b>
			</p>
			<p>但许多人是无法接受自己的这种倾向的，于是会给自己找台阶下。</p>
			<p>
				这种找台阶的迫切，会让他<b>不肯面对自己</b>。当疑似真实的自己被揭穿时，便会恼羞成怒。
			</p>
			<p>
				归根结底，人是会被情绪左右的；而许多情绪，都出于一种<b>优越感</b>的需求。
			</p>
			<p>
				<b>一旦这种优越感受损，便会不惜一切代价，通过丑化他人与给自己找台阶下，来达成满足。他人是否那么糟糕根本不重要，重要的是：</b>
			</p>
			<p>
				<b>“我不了解你，但是我希望你这么糟糕，我猜你过得很糟糕，好的，我已经相信你是这么糟糕的人啦！”</b>
			</p>
			<p>
				<b>世上绝大多数的争执与无缘无故的憎恨，大概都出于此。</b>
			</p>
		</div>
		<div class="text-footer">
			<a href="#">关注问题</a> <a href="#">424 条评论</a> <span class="hidelabel">
				<a href="#">感谢</a> <a href="#">分享</a> <a href="#">收藏</a> <a href="#">没有帮助</a>
				<a href="#">举报</a>
			</span> <a href="#">作者保留权利</a> <span class="takebackspan"><a
				class="takeback">收起</a></span>
		</div>
		<div class="separator"></div>
	</div>

	<div class="text-block">
		<div class="question">
			<a href="#">学生如何在淘宝上买到好看便宜质量好的衣服和鞋子？</a>
		</div>
		<div style="position: relative;">
			<button class="thinking">2453</button>
			<span class="author-info"> <a href="#" class="author-name">白玉豆腐</a>
				<span class="author-signal">, 撸卷狂魔（做梦</span>
			</span>
		</div>
		<div class="text">
			<span class="word">穷狗答题，大部分20-60区间~基本每家店都买过~日系小清新欧美重口暗黑古着晚晚风什么的都有~对原单有好感，仁者见仁智者见智啦~
				PS：答主只是一个年龄还没到能打工的穷狗，积蓄烧在鞋子上了，虽然推荐的便宜，但都是我买过或者持续观望很久的店~ —————…</span> <span
				class="showall">显示全部</span>
		</div>
		<div class="text-all">
			<p>穷狗答题，大部分20-60区间~基本每家店都买过~日系小清新欧美重口暗黑古着晚晚风什么的都有~对原单有好感，仁者见仁智者见智啦~</p>
			<p>PS：答主只是一个年龄还没到能打工的穷狗，积蓄烧在鞋子上了，虽然推荐的便宜，但都是我买过或者持续观望很久的店~</p>
			<br />
			<p>——————更新一家店——————</p>
			<p>✔港味潮人馆</p>
			<p>最近淘到的，衣服种类非常非常多，但我最推荐她家的裙，性价比超级高，和那种两百多的没差别~</p>
			<p>就是第一张里的小绿裙~</p>
			<br />
			<p>——————原答案——————</p>
			<br />
			<p>【重口暗黑风】</p>
			<p>✔小野古着</p>
			<p>以前挺多原单货，现在多自制。</p>
			<br />
			<p>(里面的卫衣这家买的，三十多，超级棒。)</p>
			<br />
			<br />
			<p>✔EOHSTUDIO地狱急诊室</p>
			<p>肉叔家的衣服帅哭了，还有纹身贴！等我有米就拔草！</p>
			<br />
			<p>【原单】</p>
			<p>✔大大叔外贸原单女装店</p>
			<p>他家的牛仔真的超级好，便宜好穿，就是快递要十块！</p>
			<p>(牛仔外套他家买的，old navy原单，二十多，整个春天穿过来的。)</p>
			<p>有妹砸说找不到店?</p>
			<p>http://m.tb.cn/3srjm (二维码自动识别)</p>
			<br />
			<br />
			<p>✔岳纳珊</p>
			<p>她家的白T便宜又好穿，我自己撸了两件。</p>
			<p>还卖杂七杂八的小玩意儿，适合慢慢淘。</p>
			<br />
			<p>【晚晚风】</p>
			<p>✔乌山楂</p>
			<p>入过吊带和阔腿裤，挺好的。</p>
			<br />
			<p>✔晚时光</p>
			<p>款式比较多。</p>
			<br />
			<p>【小清新】</p>
			<p>✔没烦恼很幸福</p>
			<p>白菜价呀，质量又好，挺有名的一家店了。</p>
			<p>(买过好几件毛衣和T，强推)</p>
			<br />
			<p>✔咩咩家清新文艺女装</p>
			<p>褒贬不一，我觉得还好，不过大多均码，对我这大高个不太友好(￣_￣ )</p>
			<br />
			<p>✔乌77 wu77style</p>
			<p>买了一件T一条裤子，挺好的，但是发货真是慢哭了，五六天才到。</p>
			<br />
			<p>♞♞♞♞♞♞♞♞♞♞</p>
			<br />
			<p>码字好苦，你们不留一个赞再走？！</p>
			<br />
		</div>
		<div class="text-footer">
			<a href="#">关注问题</a> <a href="#">225 条评论</a> <span class="hidelabel">
				<a href="#">感谢</a> <a href="#">分享</a> <a href="#">收藏</a> <a href="#">没有帮助</a>
				<a href="#">举报</a>
			</span> <a href="#">作者保留权利</a> <span class="takebackspan"><a>收起</a></span>
		</div>
		<div class="separator"></div>
	</div>
</body>
</html>