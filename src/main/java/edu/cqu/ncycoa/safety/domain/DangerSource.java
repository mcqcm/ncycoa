package edu.cqu.ncycoa.safety.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="SAFE_DANGERSOURCE")
public class DangerSource {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	@Column(name="DANGERSOURCE_ID")
	private Long id;//编号
	
	@Column(name="ACTICITYTYPE")
	private String activityType;//活动内别和场所
	
	@Column(name="JOBACTIVITY")
	private String jobActivity;//作业活动
	
	@Column(name="MAINDANGERSOURCE")
	private String mainDangerSource;//重点危险源 危险源
	
	@Column(name="DANGER")
	private String danger;//可能导致的事故
	
	@Column(name="DANGERLEVEL")
	private Short dangerLevel;//风险级别 重大_0,一般_1
	
	@Column(name="MEASURE_A")
	private String measureA;//控制措施A  组织策划
	
	@Column(name="MEASURE_B")
	private String measureB;//控制措施B  现场监管
	
	@Column(name="MEASURE_C")
	private String measureC;//控制措施C  应急救援
	
	@Column(name="MEMO")
	private String memo;//备注

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getActivityType() {
		return activityType;
	}

	public void setActivityType(String activityType) {
		this.activityType = activityType;
	}

	public String getJobActivity() {
		return jobActivity;
	}

	public void setJobActivity(String jobActivity) {
		this.jobActivity = jobActivity;
	}

	public String getMainDangerSource() {
		return mainDangerSource;
	}

	public void setMainDangerSource(String mainDangerSource) {
		this.mainDangerSource = mainDangerSource;
	}

	public String getDanger() {
		return danger;
	}

	public void setDanger(String danger) {
		this.danger = danger;
	}

	public Short getDangerLevel() {
		return dangerLevel;
	}

	public void setDangerLevel(Short dangerLevel) {
		this.dangerLevel = dangerLevel;
	}

	public String getMeasureA() {
		return measureA;
	}

	public void setMeasureA(String measureA) {
		this.measureA = measureA;
	}

	public String getMeasureB() {
		return measureB;
	}

	public void setMeasureB(String measureB) {
		this.measureB = measureB;
	}

	public String getMeasureC() {
		return measureC;
	}

	public void setMeasureC(String measureC) {
		this.measureC = measureC;
	}

	public String getMemo() {
		return memo;
	}

	public void setMemo(String memo) {
		this.memo = memo;
	}
	
	
}
