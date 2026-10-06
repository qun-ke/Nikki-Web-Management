package org.example.mapper;

import org.apache.ibatis.annotations.*;
import org.example.pojo.Emp;
import org.example.pojo.EmpQueryParam;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Objects;

@Mapper
public interface EmpMapper {
    //分页查询
    //@Select("select emp.*,dept.name deptName from emp left join dept on emp.dept_id=dept.id order by emp.update_time desc")
    //List<Emp> list( String name, Integer gender, LocalDate begin, LocalDate end);

    List<Emp> list(EmpQueryParam empQueryParam);

    //新增员工基本信息
    @Options(useGeneratedKeys = true,keyProperty = "id")//获取到生成的主键
    @Insert("insert into emp(username, name, gender, phone, job, salary, image, entry_date, dept_id, create_time, update_time)"+
        "values (#{username},#{name},#{gender},#{phone},#{job},#{salary},#{image},#{entryDate},#{deptId},#{createTime},#{updateTime})")
    void add(Emp emp);

    //批量删除员工基本信息
    void deleteByIds(List<Integer> ids);

    //根据ID查询员工信息
    Emp getById(Integer id);

    //根据ID修改员工基本信息
    void update(Emp emp);

    //统计员工职位人数
    List<Map<String, Object>> countEmpJobData();

    //统计员工性别人数
    List<Map<String, Object>> countGenderData();

    //用户登录
    @Select("select id,username,name from emp where username=#{username} and password=#{password}")
    Emp loginByUnAndPs(Emp emp);

    //查询所有员工（班级表单班主任下拉框使用）
    @Select("select id, username, name, gender, phone, job, salary, image, entry_date, dept_id, create_time, update_time " +
            "from emp order by update_time desc")
    List<Emp> findAll();

    //根据部门ID统计该部门下的员工人数
    @Select("select count(*) from emp where dept_id=#{deptId}")
    Integer countByDeptId(Integer deptId);
}
