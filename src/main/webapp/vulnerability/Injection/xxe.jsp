
<%@ include file="/header.jsp" %>
      <script type="text/javascript">  
              $(document).ready(function(){  
                  $("#req").click(function(){  
                  var xml = '<?xml version="1.0" encoding="UTF-8"?><users><username>Neo</username><email>neo@matrix</email></users>';
                $.ajax({
                 url: '<%=path%>/xxe.do', 
                 processData: false,
                 type: "POST", 
                 data: xml, 
                 success: function(response){
                   $("#result").html(response);
                 },
                 error: function(response) {
                    $("#result").html(response);
                 }
                  
                    });  
                  });  
              });  
            </script> 
         
 <input type="button" id="req" name="req" value="Send Request"/> <br/>
 <div id="result"></div>             
  <%@ include file="/footer.jsp" %>