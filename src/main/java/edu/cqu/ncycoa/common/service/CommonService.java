package edu.cqu.ncycoa.common.service;

import java.util.List;
import java.util.Map;
import java.util.Set;

import edu.cqu.ncycoa.common.dto.DataGridReturn;
import edu.cqu.ncycoa.common.dto.QueryDescriptor;
import edu.cqu.ncycoa.common.util.dao.TypedQueryBuilder;

public interface CommonService {

	public <T> T findEntityById(Object id, Class<T> clazz);

	public <PK, T> List<T> findEntitiesByIds(Set<PK> ids, Class<T> clazz);

	public <T> T findEntityByProperty(String propertyName, Object value, Class<T> clazz);

	public <T> List<T> findEntitiesByProperty(String propertyName, Object value, Class<T> clazz);

	public <T> List<T> findEntitiesByProperties(String propertyName, Set<Object> values, Class<T> clazz);

	public <T> List<T> findAllEntities(Class<T> clazz);

	public void removeEntityById(Object id, Class<?> clazz);
	
	public void removeEntities(Object[] ids, Class<?> clazz);

	public <T> T addEntity(T entity);

	public <T> T findEntityByJPQL(String jpql, Class<T> clazz);

	public <T> List<T> readEntitiesByJPQL(String jpql, Class<T> clazz, Object... params);

	public int executeJPQL(String jpql);

	public List<Map<String, Object>> findSetBySql(String sql, Object... objs);

	public Map<String, Object> findSingleBySql(String sql, Object... objs);

	public int executeSql(String sql, List<Object> params);

	public int executeSql(String sql, Object... params);

	public int executeSql(String sql, Map<String, Object> params);

	public Object executeSqlReturnKey(String sql, Map<String, Object> params);
	
	public DataGridReturn getDataGridReturn(@SuppressWarnings("rawtypes") final QueryDescriptor cq, final boolean isOffset);

	public abstract <T> T saveEntity(T entity);
	
	public <T> List<T> getQueryRes(TypedQueryBuilder<T> tqBuilder);
}