package dto;

public class Statistics {
	private int cashDate;
	private String kind;
	private int count;
	private int amount;
	private int cashMonth;
	
	public int getCashMonth() {
		return cashMonth;
	}
	public void setCashMonth(int cashMonth) {
		this.cashMonth = cashMonth;
	}
	
	public int getCashDate() {
		return cashDate;
	}
	public void setCashDate(int cashDate) {
		this.cashDate = cashDate;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	
}
