package org.example.mapper;

import org.apache.ibatis.annotations.*;
import org.example.pojo.Dept;

import java.util.List;
//部门信息
@Mapper
public interface DeptMapper {
    //根据id删除部门
    @Delete("delete from dept where id=#{id}")
    void deleteById(Integer id);

    //查询所有部门数据
    @Select("select id, name, create_time createTime, update_time updateTime from dept order by update_time desc ")
    List<Dept> findAll();

    //新增部门
    @Insert("insert into dept(name, create_time, update_time) values (#{name},#{createTime},#{updateTime})")
    void add(Dept dept);

    //根据id查询部门
    @Select("select id, name, create_time, update_time from dept where id=#{id}")
    Dept getById(Integer id);

    //修改部门信息
    @Update("update dept set name=#{name},update_time=#{updateTime} where id=#{id}")
    void update(Dept dept);
}
