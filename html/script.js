window.addEventListener("message", (event) => {
  const data = event.data;

  if (data.action === "close") {
    document.body.style.visibility = "hidden";
  } else if (data.action === "showQuest") {
    document.getElementById("quest-title").textContent = data.title;
    document.getElementById("quest-text").textContent = data.description;

    const container = document.getElementById("request-images");
    container.innerHTML = "";

    if (Array.isArray(data.request)) {
      data.request.forEach((item) => {
        const img = document.createElement("img");
        img.src = `https://cfx-nui-rsg-inventory/html/images/${item.item}.png`;
        img.alt = item.item;
        img.title = `${item.quantity}x ${item.item}`;
        container.appendChild(img);
      });
    }

    document.body.style.visibility = "visible";
  }
});

function closeUI() {
  fetch(`https://${GetParentResourceName()}/closeUI`, {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify({}),
  });

  document.body.style.visibility = "hidden";
}

document.getElementById("close-button").addEventListener("click", closeUI);

document
  .getElementById("complete-button")
  .addEventListener("click", function () {
    fetch(`https://${GetParentResourceName()}/completeQuest`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: JSON.stringify({}),
    });
  });
