package com.myself.gecko.dao.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.myself.gecko.constant.Constant;
import com.myself.gecko.dao.IArticleDao;
import com.myself.gecko.domain.Article;
import com.myself.gecko.domain.Topic;
import com.myself.gecko.domain.User;
import com.myself.gecko.util.C3P0Utils;

public class ArticleDaoImpl extends BaseDaoImpl<Article> implements IArticleDao {

	@Override
	public void save(Article article) throws Exception {
		String sql = "insert into article values(?, ?, ?, ?, ?, ?, ?, ?)";
		Object[] params = { null, article.getUser().getId(), article.getTopic().getId(), article.getTitlePicture(),
				article.getTitle(), article.getPureContent(), article.getContent(), article.getDate()};
		CU(sql, params);
	}

	@Override
	public void agree(User user, int aid) throws Exception {
		int uid = user.getId();
		QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
		String sql = "select count(*) from article_agree where aid = ? and uid = ?";
		Long count = (Long) queryRunner.query(sql, new ScalarHandler(), aid, uid);
		if (count.intValue() == 0) {
			sql = "insert into article_agree values(null, ?, ?, ?)";
			queryRunner.update(sql, aid, uid, new Date());
		}
	}

	@Override
	public void disagree(User user, int aid) throws Exception {
		int uid = user.getId();
		QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
		String sql = "delete from article_agree where aid = ? and uid = ?";
		queryRunner.update(sql, aid, uid);
	}

	@Override
	public Article findAnswerById(int aid, User user) throws Exception {
		Article article = findById(aid);

		String sql = "select uid, tid from article where id = ?";
		QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
		Map<String, Object> map = queryRunner.query(sql, new MapHandler(), aid);

		// 封装作者
		sql = "select * from user where id = ?";
		User author = queryRunner.query(sql, new BeanHandler<>(User.class), map.get("uid"));
		article.setUser(author);

		// 封装话题
		sql = "select * from topic where id = ?";
		Topic topic = queryRunner.query(sql, new BeanHandler<>(Topic.class), map.get("tid"));
		article.setTopic(topic);

		// 查询赞同数
		sql = "select count(*) from article_agree where aid = ?";
		Long agreeCount = (Long) queryRunner.query(sql, new ScalarHandler(), aid);
		article.setAgreeCount(agreeCount.intValue());

		// 查询评论数
		sql = "select count(*) from comment where type = ? and targetId = ?";
		Long commentCount = (Long) queryRunner.query(sql, new ScalarHandler(), Constant.COMMENT_TYPE_ARTICLE, aid);
		article.setCommentCount(commentCount.intValue());

		// 查询是否点过赞
		if (user != null) {
			int uid = user.getId();
			sql = "select count(*) from article_agree where aid = ? and uid = ?";
			Long agree = (Long) queryRunner.query(sql, new ScalarHandler(), aid, uid);
			article.setAgree(agree.intValue());
		}
		return article;
	}

	@Override
	public List<Article> findArticleByOrderStyle(int tid, User user, String orderStyle, int currentPage, int pageSize)
			throws Exception {
		QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
		String sql = null;
		if ("hot".equals(orderStyle)) {
			sql = "select article.id from article, article_agree where tid = ? and article.id = article_agree.aid group by article.id order by count(article_agree.id) limit ?, ?";
		} else {
			sql = "select id from article where tid = ? order by date desc limit ?, ?";
		}
		List<Article> aList = queryRunner.query(sql, new BeanListHandler<>(Article.class), tid, (currentPage - 1) * pageSize, pageSize);
		List<Article> list = new ArrayList<>();
		
		for (Article article : aList) {
			article = findAnswerById(article.getId(), user);
			list.add(article);
		}
		return list;
	}
}
