<!-- @format -->

<%@ Page Language="C#" %> <%@ Import Namespace="System.Web.Security" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
  public void Login_OnClick(object sender, EventArgs args)
  {
      if (FormsAuthentication.Authenticate(UsernameTextbox.Text, PasswordTextbox.Text))
      {
          FormsAuthentication.RedirectFromLoginPage(UsernameTextbox.Text, false); // NotPublicCheckBox.Checked
      }
      else
      {
          Msg.Text = "Login failed. Please check your user name and password and try again.";
      }
  }
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <link rel="icon" href="assets/img/docs-icon.png">
    <title>NetSuite Docs Login</title>
    <link
      rel="stylesheet"
      href="assets/templates/clean-jsdoc-theme.min.css"
    />
  </head>
  <body
    class="dark"
    data-theme="dark"
  >
    <style>
      @import url('https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Koulen&family=Lato&family=Nunito&family=Playfair+Display:ital@1&family=Prata&family=Raleway:ital,wght@1,100&family=Roboto&family=Roboto+Condensed&family=Teko&display=swap');

      .btn{

      font-family: Roboto, sans-serif;
      font-weight: 0;
      font-size: 14px;
      color: #fff;
      background-color: #0b3f7e;
      padding: 10px 30px;
      border: solid #0b3f7e 2px;
      box-shadow: rgb(0, 0, 0) 0px 0px 0px 0px;
      border-radius: 50px;
      transition : 1000ms;
      transform: translateY(0);
      display: flex;
      flex-direction: row;
      align-items: center;
      cursor: pointer;
      }

      .btn:hover{

      transition : 1000ms;
      padding: 10px 50px;
      transform : translateY(-0px);
      background-color: #5cb85c;
      color: #ffffff;
      border: solid 2px #5cb85c;
      }
    </style>
    <style>
      div {
        align-content: center;
        text-align: center;
      }
      button.btn, input[name='LoginButton'] {
        margin: auto;
      }
      form {
        padding: 2em;
      }
    </style>
    <form
      id="form1"
      runat="server"
    >
    <div>
      <h3>Developers Login</h3>

      <asp:Label
        ID="Msg"
        ForeColor="maroon"
        runat="server"
      /><br />
      <label for="UserName">User name</label>
      <br />
      <asp:TextBox
        ID="UsernameTextbox"
        runat="server"
      /><br />
      <label for="Password">Password</label>
      <br />
      <asp:TextBox
        ID="PasswordTextbox"
        runat="server"
        TextMode="Password"
      /><br />
      <br />
      <asp:Button
        ID="LoginButton"
        Text="Login"
        OnClick="Login_OnClick"
        runat="server"
        class="btn"
      />
    </form>
  </div>
  </body>
</html>
