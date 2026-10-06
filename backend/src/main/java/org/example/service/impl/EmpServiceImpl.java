package org.example.service.impl;

import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import org.example.mapper.EmpExprMapper;
import org.example.mapper.EmpMapper;
import org.example.pojo.*;
import org.example.service.EmpService;
import org.example.utils.JwtUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EmpServiceImpl implements EmpService {
    @Autowired
    private EmpMapper empMapper;
    @Autowired
    private EmpExprMapper empExprMapper;
    //分页查询
    @Override
    public PageResult<Emp> page(EmpQueryParam empQueryParam){
        //设置分页参数
        PageHelper.startPage(empQueryParam.getPage(),empQueryParam.getPageSize());
        List<Emp> empList=empMapper.list(empQueryParam);
        Page<Emp> p=(Page<Emp>) empList;
        return new PageResult<Emp>(p.getTotal(),p.getResult());
    }
    //新增员工
    @Transactional//交给事务管理
    @Override
    public void add(Emp emp) {
        //基本信息
        emp.setCreateTime(LocalDateTime.now());
        emp.setUpdateTime(LocalDateTime.now());
        empMapper.add(emp);

        //工作经历信息
        List<EmpExpr> exprList=emp.getExprList();
        if(!CollectionUtils.isEmpty(exprList)){
            //再把获取到的主键赋值给empId
            exprList.forEach(empExpr->{empExpr.setEmpId(emp.getId());});
            empExprMapper.addBatch(exprList);
        }
    }

    //批量删除员工
    @Transactional(rollbackFor = {Exception.class})
    @Override
    public void delete(List<Integer> ids) {
        //删除员工基本信息
        empMapper.deleteByIds(ids);
        //批量删除员工工作经历信息
        empExprMapper.deleteByExprIds(ids);
    }

    //根据ID查询员工信息
    @Override
    public Emp getById(Integer id) {
        return empMapper.getById(id);
    }

    //修改员工信息
    @Transactional(rollbackFor = {Exception.class})
    @Override
    public void update(Emp emp) {
        //根据ID修改员工基本信息
        emp.setUpdateTime(LocalDateTime.now());
        empMapper.update(emp);

        //根据ID修改员工工作经历信息
        //1.先删除
        empExprMapper.deleteByExprIds(Arrays.asList(emp.getDeptId()));
        //2.再添加（要判断emp对象中有没有工作经历信息）
        List<EmpExpr> exprList=emp.getExprList();
        if (!CollectionUtils.isEmpty(exprList)){
            exprList.forEach(empExpr -> empExpr.setEmpId(emp.getId()));
            empExprMapper.addBatch(exprList);
        }
    }

    //用户登录
    @Override
    public LoginInfo login(Emp emp) {
        //根据用户名和密码查询员工信息
        Emp empResult = empMapper.loginByUnAndPs(emp);
        //判断：该员工是否存在，如果存在则返回登录信息，否则返回null
        if (empResult != null) {
            //生成JWT令牌
            Map<String,Object> claims=new HashMap<>();
            claims.put("id",empResult.getId());
            claims.put("username",empResult.getUsername());
            String token= JwtUtils.generateToken(claims);
            return new LoginInfo(empResult.getId(), empResult.getUsername(), empResult.getName(), token);
        }
        return null;
    }

    //查询所有员工（班级表单班主任下拉框使用）
    @Override
    public List<Emp> findAll() {
        return empMapper.findAll();
    }
}
