package org.example.mapper;

import org.apache.ibatis.annotations.*;
import org.example.pojo.Clazz;
import org.example.pojo.ClazzQueryParam;

import java.util.List;
import java.util.Map;

@Mapper
public interface ClazzMapper {
    //条件分页查询（关联员工表，查询班主任姓名）
    List<Clazz> list(ClazzQueryParam clazzQueryParam);

    //根据ID删除班级
    @Delete("delete from clazz where id=#{id}")
    void deleteById(Integer id);

    //新增班级
    @Options(useGeneratedKeys = true, keyProperty = "id") //获取生成的主键
    @Insert("insert into clazz(name, room, begin_date, end_date, master_id, subject, create_time, update_time) " +
            "values(#{name},#{room},#{beginDate},#{endDate},#{masterId},#{subject},#{createTime},#{updateTime})")
    void add(Clazz clazz);

    //根据ID查询班级
    @Select("select id, name, room, begin_date, end_date, master_id, subject, create_time, update_time from clazz where id=#{id}")
    Clazz getById(Integer id);

    //修改班级
    void update(Clazz clazz);

    //查询所有班级
    @Select("select id, name, room, begin_date, end_date, master_id, subject, create_time, update_time " +
            "from clazz order by update_time desc")
    List<Clazz> findAll();

    //统计每一个班级的学员人数（left join 保证没有学员的班级人数为0）
    @Select("select c.name name, count(s.id) value from clazz c " +
            "left join student s on c.id = s.clazz_id " +
            "group by c.id, c.name order by c.id")
    List<Map<String, Object>> countStudentByClazz();
}
