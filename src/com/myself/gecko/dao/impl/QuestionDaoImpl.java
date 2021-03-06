package com.myself.gecko.dao.impl;

import static org.hamcrest.CoreMatchers.nullValue;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.MapHandler;
import org.apache.commons.dbutils.handlers.MapListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;
import org.apache.commons.lang.StringUtils;

import com.myself.gecko.constant.Constant;
import com.myself.gecko.dao.IQuestionDao;
import com.myself.gecko.domain.Answer;
import com.myself.gecko.domain.Comment;
import com.myself.gecko.domain.Question;
import com.myself.gecko.domain.Topic;
import com.myself.gecko.domain.User;
import com.myself.gecko.util.C3P0Utils;

public class QuestionDaoImpl extends BaseDaoImpl<Question> implements IQuestionDao {

    // 保存问题
    @Override
    public void save(Question question) throws Exception {
        String sql = "insert into question values(?, ?, ?, ?, ?, ?, ?, ?, ?)";
        Object[] params = {null, question.getUser().getId(), question.getTopic().getId(),
                question.getAnonymous(), question.getTitle(), question.getPureContent(),
                question.getContent(), question.getDate(), 0};
        CU(sql, params);
    }

    // 根据UID查询问题
    @Override
    public List<Question> ajaxQueryByUid(int currentPage, int pageSize, int uid)
            throws SQLException {
        String whereClause = "where uid = " + uid;
        return selectLimitByWhere(currentPage, pageSize, whereClause);
    }

    // 完善问题信息
    /*public Question findQuestionById(int id, User user) throws Exception {
        QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
        // 查询问题
        String sql = "select * from question where id = ?";
        Question question = queryRunner.query(sql, new BeanHandler<>(Question.class), id);

        // 查询是否已经关注
        if (user != null) {
            int uid = user.getId();
            sql = "select count(*) from question_watch where uid = ? and qid = ?";
            Long count = (Long) queryRunner.query(sql, new ScalarHandler(), uid, id);
            question.setWatched(count.intValue());
        }

        // 查询话题并封装
        sql = "select topic.id, topic.name from topic join question on question.tid = topic.id where question.id = ?";
        Map<String, Object> map = queryRunner.query(sql, new MapHandler(), id);
        Topic topic = new Topic();
        BeanUtils.populate(topic, map);
        question.setTopic(topic);

        // 查询回答并封装
        sql = "select id from answer where qid = ?";
        List<Map<String, Object>> list = queryRunner.query(sql, new MapListHandler(), id);
        for (Map<String, Object> map2 : list) {
            question.getAnswerList().add(new Answer());
        }

        // 查询关注数并封装
        sql = "select count(*) from question_watch where qid = ?";
        Long watchCount = (Long) queryRunner.query(sql, new ScalarHandler(), id);
        question.setWatchCount(watchCount.intValue());

        // 查询评论并封装
        sql = "select id from comment where targetId = ? and type = ?";
        List<Map<String, Object>> list3 =
                queryRunner.query(sql, new MapListHandler(), id, Constant.COMMENT_TYPE_QUESTION);
        for (Map<String, Object> map4 : list3) {
            question.getCommentList().add(new Comment());
        }

        // 查询提问者并封装
        sql = "select uid from question where id = ?";
        int uid = -1;
        List<Map<String, Object>> list4 = queryRunner.query(sql, new MapListHandler(), id);
        for (Map<String, Object> map4 : list4) {
            uid = (int) map4.get("uid");
        }
        sql = "select * from user where id = ?";
        User asker = queryRunner.query(sql, new BeanHandler<>(User.class), uid);
        question.setUser(asker);
        return question;
    }*/
    
    /**  
     * 完善问题信息
     */
    @Override
    public void improveQuestionInfo(Question question, User user) throws Exception {
        QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
        // 查询话题并封装
        String sql = "select topic.id, topic.name from topic join question on question.tid = topic.id where question.id = ?";
        Map<String, Object> map = queryRunner.query(sql, new MapHandler(), question.getId());
        Topic topic = new Topic();
        BeanUtils.populate(topic, map);
        question.setTopic(topic);
        
        // 查询是否已经关注
        if (user != null) {
            int uid = user.getId();
            sql = "select count(*) from question_watch where uid = ? and qid = ?";
            Long count = (Long) queryRunner.query(sql, new ScalarHandler(), uid, question.getId());
            question.setWatched(count.intValue());
        }
        
        // 查询回答并封装
        sql = "select id from answer where qid = ?";
        List<Map<String, Object>> list = queryRunner.query(sql, new MapListHandler(), question.getId());
        for (Map<String, Object> map2 : list) {
            question.getAnswerList().add(new Answer());
        }
        
        // 查询关注数并封装
        sql = "select count(*) from question_watch where qid = ?";
        Long watchCount = (Long) queryRunner.query(sql, new ScalarHandler(), question.getId());
        question.setWatchCount(watchCount.intValue());
        
        // 查询评论并封装
        sql = "select id from comment where targetId = ? and type = ?";
        List<Map<String, Object>> list3 =
                queryRunner.query(sql, new MapListHandler(), question.getId(), Constant.COMMENT_TYPE_QUESTION);
        for (Map<String, Object> map4 : list3) {
            question.getCommentList().add(new Comment());
        }
        
        // 查询提问者并封装
        sql = "select uid from question where id = ?";
        int uid = -1;
        List<Map<String, Object>> list4 = queryRunner.query(sql, new MapListHandler(), question.getId());
        for (Map<String, Object> map4 : list4) {
            uid = (int) map4.get("uid");
        }
        sql = "select * from user where id = ?";
        User asker = queryRunner.query(sql, new BeanHandler<>(User.class), uid);
        question.setUser(asker);
    }

    // 关注问题
    @Override
    public void addWatch(int qid, User user) throws Exception {
        int uid = user.getId();
        QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
        String sql = "select count(*) from question_watch where qid = ? and uid = ?";
        Long count = (Long) queryRunner.query(sql, new ScalarHandler(), qid, uid);
        if (count.intValue() == 0) {
            sql = "insert into question_watch values(null, ?, ?, ?)";
            queryRunner.update(sql, uid, qid, new Date());
        }
    }

    // 取消关注问题
    @Override
    public void cancleWatch(int qid, User user) throws Exception {
        int uid = user.getId();
        QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
        String sql = "delete from question_watch where qid = ? and uid = ?";
        queryRunner.update(sql, qid, uid);
    }

    // 查询相关问题(同一话题)
    @Override
    public List<Question> findRelativeQuestion(int tid) throws Exception {
        String whereClause = "where tid = " + tid + " order by rand()";
        return this.selectLimitByWhere(1, Constant.RELATIVE_QUESTION_COUNT, whereClause);
    }

    // 更新问题查看次数
    @Override
    public void visitQuestion(int id) throws Exception {
        String sql = "update question set lookCount = lookCount + 1 where id = ?";
        Object[] params = {id};
        CU(sql, params);
    }

    // 根据tid查询该话题下最近被关注的问题
    @Override
    public List<Question> findLastWatchQuestionListByTid(int tid, int currentPage, int pageSize)
            throws Exception {
        QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
        String sql =
                "select distinct question.id, question.title from question left join question_watch on question.id = question_watch.qid where question.tid = ? order by question_watch.date desc limit ?, ?";
        return queryRunner.query(sql, new BeanListHandler<>(Question.class), tid,
                (currentPage - 1) * pageSize, pageSize);
    }

    // 根据tid查询该话题下最新添加的问题
    @Override
    public List<Question> findNewestQuestion(int topicId, int currentPage, int pageSize) throws Exception {
        QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
        String sql = "select * from question where tid = ? order by date desc limit ?, ?";
        List<Question> list = queryRunner.query(sql, new BeanListHandler<>(Question.class), topicId,
                (currentPage - 1) * pageSize, pageSize);
        for (Question question : list) {
            improveQuestionInfo(question, null);
        }
        return list;
    }

    // 查询已关注的问题
    @Override
    public List<Question> findWatchedQuestion(User user, int uid, int currentPage, int pageSize) throws Exception {
        QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
        String sql = "select distinct question.* from question left join question_watch on question.id = question_watch.qid where question_watch.uid = ? limit ?, ?";
        List<Question> list = queryRunner.query(sql, new BeanListHandler<>(Question.class), uid, (currentPage - 1) * pageSize, pageSize);
        
        for (Question question : list) {
            improveQuestionInfo(question, user);
        }
        return list;
    }

    // 查询关注话题中新增的问题
    @Override
    public List<Question> findNewestQuestionInWatchedTopics(User user, int currentPage,
            int pageSize) throws Exception {
        QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
        String sql = "select question.* from question left join topic on topic.id = question.tid join topic_watch on topic.id = topic_watch.tid where topic_watch.uid = ? order by question.date desc limit ?, ?";
        List<Question> list = queryRunner.query(sql, new BeanListHandler<>(Question.class),
                user.getId(), (currentPage - 1) * pageSize, pageSize);
        for (Question question : list) {
            improveQuestionInfo(question, user);
        }
        return list;
    }

    // 查询关注用户新关注的问题
    @Override
    public List<Question> findNewWatchedQuestionWithFriends(User user, int currentPage,
            int pageSize) throws Exception {
        List<Question> questions = new ArrayList<>();
        String sql =
                "select q.id, uw.hostId from question q,question_watch qw, user_watch uw where q.id = qw.qid and qw.uid = uw.hostId and uw.watcherId = ? limit ?,?";
        QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
        List<Map<String, Object>> list = queryRunner.query(sql, new MapListHandler(), user.getId(),
                (currentPage - 1) * pageSize, pageSize);
        for (Map<String, Object> map : list) {
            Question question = findById((int) map.get("id"));
            improveQuestionInfo(question, user);
            sql = "select id, name from user where id = ?";
            User watcher = queryRunner.query(sql, new BeanHandler<>(User.class), (int) map.get("hostId"));
            question.setWatcher(watcher);
            question.setMark(13);
            questions.add(question);
        }
        return questions;
    }

    // 查询所有新增的问题
    @Override
    public List<Question> findNewestQuestions(int currentPage, int pageSize) throws Exception {
        String whereClause = "order by date desc";
        List<Question> list = selectLimitByWhere(currentPage, pageSize, whereClause);
        for (Question question : list) {
            improveQuestionInfo(question, null);
        }
        return list;
    }

    /**
     * 根据关键字查找相关联的问题
     */
    @Override
    public List<Question> findAssociatedByKeywords(String keywords, int currentPage, int pageSize) throws Exception {
        keywords = keywords.trim();
        if (StringUtils.isNotEmpty(keywords)) {
            QueryRunner queryRunner = new QueryRunner(C3P0Utils.getDataSource());
            String sql = "select q.id, q.title from question q left join answer a on a.qid = q.id where q.title like ? group by q.id order by count(a.id) desc limit ?, ?";
            return queryRunner.query(sql, new BeanListHandler<>(Question.class), "%" + keywords + "%", (currentPage - 1) * pageSize, pageSize);
        }
        return null;
    }

}
