package org.example.service;

import org.example.pojo.Dept;

import java.util.List;

public interface DeptService {
    //根据Id删除部门
    void deleteById(Integer id);

    //查询所有部门数据
    List<Dept> findAll();

    //新增部门
    void add(Dept dept);

    //根据id查询部门
    Dept getById(Integer id);

    //修改部门信息
    void update(Dept dept);
}
