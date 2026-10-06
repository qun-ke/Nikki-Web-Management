package org.example.service.impl;

import org.example.exception.BusinessException;
import org.example.mapper.DeptMapper;
import org.example.mapper.EmpMapper;
import org.example.pojo.Dept;
import org.example.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class DeptServiceImpl implements DeptService {
    @Autowired
    private DeptMapper deptMapper;
    @Autowired
    private EmpMapper empMapper;

    //根据id删除部门
    @Override
    public void deleteById(Integer id) {
        //1.先统计该部门下的员工人数
        Integer count = empMapper.countByDeptId(id);
        //2.如果部门下有员工，则不允许删除，抛出业务异常
        if (count != null && count > 0) {
            throw new BusinessException("对不起，当前部门下有员工，不能直接删除！");
        }
        //3.没有员工，执行删除
        deptMapper.deleteById(id);
    }

    //查询所有部门数据
    @Override
    public List<Dept> findAll() {
        return deptMapper.findAll();
    }

    //新增部门
    @Override
    public void add(Dept dept) {
        //补充属性：createTime,updateTime
        dept.setCreateTime(LocalDateTime.now());
        dept.setUpdateTime(LocalDateTime.now());
        deptMapper.add(dept);
    }

    //根据id查询部门
    @Override
    public Dept getById(Integer id) {
        return deptMapper.getById(id);
    }

    @Override
    public void update(Dept dept) {
        dept.setUpdateTime(LocalDateTime.now());
        deptMapper.update(dept);
    }

}
