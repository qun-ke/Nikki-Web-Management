package org.example.service;

import org.example.pojo.Clazz;
import org.example.pojo.ClazzQueryParam;
import org.example.pojo.PageResult;

import java.util.List;

public interface ClazzService {
    //条件分页查询
    PageResult<Clazz> page(ClazzQueryParam clazzQueryParam);

    //根据ID删除班级
    void deleteById(Integer id);

    //新增班级
    void add(Clazz clazz);

    //根据ID查询班级
    Clazz getById(Integer id);

    //修改班级
    void update(Clazz clazz);

    //查询所有班级
    List<Clazz> findAll();
}
