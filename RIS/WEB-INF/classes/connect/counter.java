package connect;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Comparator;

public class counter implements Comparable<Object>
{
	private int total;
	private int record_id;
	
	public counter (int total, int record_id)
	{
		this.total = total;
		this.record_id = record_id;
	}
	
	public int getTotal ()
	{
		return this.total;
	}
	
	public int getRecordID ()
	{
		return this.record_id;
	}
	
	@Override
	public int compareTo (Object o) 
	{
		// return 1 if this > o
		// return -1 if this < o
		// otherwise 0
		if (this.getTotal () > ((counter) o).getTotal ())
			return -1;
		else if (this.getTotal () < ((counter) o).getTotal ())
			return 1;
		else
			return 0;
	}
}

class counterComp implements Comparator<Object> 
{
	@Override
	public int compare (Object o1, Object o2) 
	{
		return ((counter) o1).compareTo ((counter) o2);
	}
}