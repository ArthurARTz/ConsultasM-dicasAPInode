async function carregar(endpoint) {
  try {
    const res = await fetch("http://localhost:3000" + endpoint);
    const dados = await res.json();

    const thead = document.getElementById("thead");
    const tbody = document.getElementById("tbody");

    tbody.innerHTML = "";
    thead.innerHTML = "";

    if (!dados || dados.length === 0) {
      tbody.innerHTML = "<tr><td>Nenhum resultado encontrado</td></tr>";
      return;
    }

    // Cabeçalhos automáticos
    const colunas = Object.keys(dados[0]);

    thead.innerHTML = `
      <tr>
        ${colunas.map(c => `<th>${c.toUpperCase()}</th>`).join("")}
      </tr>
    `;

    // Linhas automáticas
    dados.forEach(item => {
      tbody.innerHTML += `
        <tr>
          ${colunas.map(c => `<td>${item[c]}</td>`).join("")}
        </tr>
      `;
    });

  } catch (err) {
    console.error("Erro ao carregar:", err);
  }
}
