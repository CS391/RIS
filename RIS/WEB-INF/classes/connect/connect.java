package connect;

import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.awt.image.BufferedImage;
import java.awt.Graphics2D;
import java.awt.*;
import java.awt.geom.*;

public class connect
{
	private static String ccid;
	private static String pass;
	
	public connect ()
	{
		
	}
	
	public static void setLogin (String c, String p)
	{
		ccid = c;
		pass = p;
	}
	
	public static Connection dbConnect ()
	{
		Connection conn = null;
		
		String driverName = "oracle.jdbc.driver.OracleDriver";
		String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
		try
		{
			//load and register the driver
			Class drvClass = Class.forName (driverName); 
			DriverManager.registerDriver ((Driver) drvClass.newInstance ());
		}
		catch (Exception ex)
		{
			System.out.println ("<hr>" + ex.getMessage () + "<hr>");
		}

		try
		{
			//establish the connection 
			conn = DriverManager.getConnection (dbstring, ccid, pass);
			conn.setAutoCommit (false);
		}
		catch (Exception ex)
		{
			System.out.println ("<hr>" + ex.getMessage () + "<hr>");
		}
		
		return conn;
	}
	
	public static String getDateStringFromDateString (String date)
	{
		SimpleDateFormat dateFormat = new SimpleDateFormat ("yyyy-MM-dd");
		Date convertedDate = new Date ();
		try
		{
			convertedDate = dateFormat.parse (date);
		}
		catch (ParseException e)
		{
			// TODO Auto-generated catch block
			System.out.println ("<hr>" + e.getMessage () + "<hr>");
		}   
	    SimpleDateFormat finalFormat = new SimpleDateFormat ("dd-MMM-yy");
	    
	    return finalFormat.format (convertedDate);
	}
	
	public static BufferedImage scale (BufferedImage source, int w, int h) 
	{
		//int w = (int) (source.getWidth () * ratio);
		//int h = (int) (source.getHeight () * ratio);
		if (source.getHeight () > source.getWidth ()) 
		{
			w = (source.getWidth () * w)
					/ source.getHeight ();
		}
		else if (source.getHeight () < source.getWidth ()) 
		{
			h = (source.getHeight () * w)
					/ source.getWidth ();
		}
		BufferedImage bi = getCompatibleImage (w, h);
		Graphics2D g2d = bi.createGraphics ();
		double xScale = (double) w / source.getWidth ();
		double yScale = (double) h / source.getHeight ();
		AffineTransform at = AffineTransform.getScaleInstance (xScale,yScale);
		g2d.drawRenderedImage (source, at);
		g2d.dispose ();
		return bi;
	}
	
	private static BufferedImage getCompatibleImage (int w, int h) 
	{
		GraphicsEnvironment ge = GraphicsEnvironment.getLocalGraphicsEnvironment ();
		GraphicsDevice gd = ge.getDefaultScreenDevice ();
		GraphicsConfiguration gc = gd.getDefaultConfiguration ();
		BufferedImage image = gc.createCompatibleImage (w, h);
		return image;
	}
}