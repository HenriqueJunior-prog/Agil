<!-- index.jsp -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
    String etapa = request.getParameter("etapa");
    if (etapa == null) etapa = "1";

    String cpf = request.getParameter("cpf");
    String nome = "Usuário Exemplo";
    String dataNascimento = "03/03/2000";
    String mae = "MARIA DA SILVA";

    List<String> datas = Arrays.asList(dataNascimento, "01/03/2003", "05/03/2006", "Nenhuma das alternativas");
    Collections.shuffle(datas);

    List<String> maes = Arrays.asList(mae, "CARLA FERREIRA", "JULIANA FERREIRA", "Nenhuma das alternativas");
    Collections.shuffle(maes);
%>
<html>
<head>
  <title>Verificação Rápida</title>
  <style>
    body { font-family: Arial; background: #f9f9f9; padding: 20px; }
    .box { background: white; max-width: 500px; margin: auto; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px #ccc; }
    input, button { width: 100%; padding: 10px; margin-top: 10px; }
    button { background: #16a34a; color: white; border: none; cursor: pointer; }
  </style>
</head>
<body>
  <div class="box">
    <% if (etapa.equals("1")) { %>
      <h2>Verificação Rápida</h2>
      <form method="get">
        <input type="hidden" name="etapa" value="2" />
        <p>Digite seu CPF:</p>
        <input type="text" name="cpf" placeholder="000.000.000-00" required />
        <button type="submit">Verificar</button>
      </form>
    <% } else if (etapa.equals("2")) { %>
      <h2>Verificação Concluída</h2>
      <p><strong>Nome:</strong> <%= nome %></p>
      <p><strong>CPF:</strong> <%= cpf %></p>
      <form method="get">
        <input type="hidden" name="etapa" value="3" />
        <input type="hidden" name="cpf" value="<%= cpf %>" />
        <button type="submit">Continuar</button>
      </form>
    <% } else if (etapa.equals("3")) { %>
      <h2>Confirme sua Data de Nascimento</h2>
      <% for (String d : datas) { %>
        <form method="get" style="margin-top: 10px;">
          <input type="hidden" name="etapa" value="4" />
          <input type="hidden" name="cpf" value="<%= cpf %>" />
          <input type="hidden" name="dataNasc" value="<%= d %>" />
          <button type="submit"><%= d %></button>
        </form>
      <% } %>
    <% } else if (etapa.equals("4")) { %>
      <h2>Confirme o Nome da sua Mãe</h2>
      <% for (String m : maes) { %>
        <form method="get" style="margin-top: 10px;">
          <input type="hidden" name="etapa" value="5" />
          <input type="hidden" name="cpf" value="<%= cpf %>" />
          <input type="hidden" name="mae" value="<%= m %>" />
          <button type="submit"><%= m %></button>
        </form>
      <% } %>
    <% } else if (etapa.equals("5")) { %>
      <h2>Opções de Crédito Disponíveis</h2>
      <p>Você pode solicitar um empréstimo de R$ 2.200 até R$ 35.000 com aprovação imediata.</p>
      <ul>
        <li>Aprovação instantânea</li>
        <li>Transferência no mesmo dia</li>
        <li>Processo 100% digital</li>
      </ul>
      <button>Selecionar Oferta</button>
    <% } %>
  </div>
</body>
</html>
