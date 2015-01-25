
<%@page import="org.hibernate.cfg.Configuration"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="java.util.List"%>
<%@page import="org.cysecurity.cspf.jvl.model.orm.Users"%>
<%@page import="org.hibernate.Query"%>
<%@page import="org.hibernate.Session"%>
<%@ include file="/header.jsp" %>
<%!
private static String queryUsers(Session session,String id) {
        Query query = session.createQuery("from Users where id="+id);                 
        List <Users>list = query.list();
        java.util.Iterator<Users> iter = list.iterator();
        String results="Details:<br/>---------------<br/>";
        if (iter.hasNext()) { 
            Users users = iter.next();
           results+= "Name: " + users.getUsername() +"<br/> About: " + users.getAbout();
        }
         session.getTransaction().commit();
        return results;
        
    }

%>
<%

    try{
        
       //Reading config from properties file: 
        String dbuser=properties.getProperty("dbuser");
         String dbpass = properties.getProperty("dbpass");
       String dbfullurl = properties.getProperty("dburl")+properties.getProperty("dbname");
       String jdbcdriver = properties.getProperty("jdbcdriver");    
       
        Configuration configuration = new Configuration();
       configuration.setProperty( "hibernate.connection.driver_class",jdbcdriver);
       configuration.setProperty( "hibernate.connection.url",dbfullurl);
       configuration.setProperty( "hibernate.connection.username", dbuser);
        configuration.setProperty( "hibernate.connection.password", dbpass);
       configuration.setProperty( "hibernate.dialect","org.hibernate.dialect.MySQLDialect");
       
 
       configuration.addResource("Users.hbm.xml");
        SessionFactory factory;            
        factory=configuration.buildSessionFactory();
          Session ormSession = factory.openSession();
    
        ormSession.beginTransaction();
         
        out.print(queryUsers(ormSession,request.getParameter("id")));
        
        }
        catch(Exception e)
        {             
            out.print(e);
        }
        
        %>

<%@ include file="/footer.jsp" %>