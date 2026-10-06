package org.example.mapper;

import org.apache.ibatis.annotations.*;
import org.example.pojo.Student;
import org.example.pojo.StudentQueryParam;

import java.util.List;
import java.util.Map;

@Mapper
public interface StudentMapper {
    //条件分页查询（关联班级表，查询班级名称）
    List<Student> list(StudentQueryParam studentQueryParam);

    //批量删除学员
    void deleteByIds(List<Integer> ids);

    //新增学员（违纪次数、违纪扣分由数据库默认值0处理）
    @Options(useGeneratedKeys = true, keyProperty = "id") //获取生成的主键
    @Insert("insert into student(name, no, gender, phone, id_card, is_college, address, degree, graduation_date, clazz_id, create_time, update_time) " +
            "values(#{name},#{no},#{gender},#{phone},#{idCard},#{isCollege},#{address},#{degree},#{graduationDate},#{clazzId},#{createTime},#{updateTime})")
    void add(Student student);

    //根据ID查询学员
    Student getById(Integer id);

    //修改学员
    void update(Student student);

    //违纪处理：违纪次数+1，违纪扣分+score
    @Update("update student set violation_count = violation_count + 1, violation_score = violation_score + #{score}, update_time = now() " +
            "where id = #{id}")
    void updateViolation(@Param("id") Integer id, @Param("score") Integer score);

    //统计学员学历信息
    @Select("select (case degree when 1 then '初中' when 2 then '高中' when 3 then '大专' " +
            "when 4 then '本科' when 5 then '硕士' when 6 then '博士' else '其他' end) name, " +
            "count(*) value from student group by degree")
    List<Map<String, Object>> countDegreeData();
}
