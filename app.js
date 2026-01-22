async function loadBodegas() {
  const bodegaSelect = document.getElementById("bodega");

  bodegaSelect.innerHTML = '<option value="">Cargando bodegas...</option>';

  try {
    const response = await fetch("get_bodegas.php");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const bodegas = await response.json();

    bodegaSelect.innerHTML = '<option value="" selected></option>';

    if (bodegas.error) {
      alert("Error cargando bodegas: " + bodegas.error);
      return;
    }

    bodegas.forEach((bodega) => {
      const option = document.createElement("option");
      option.value = bodega.bode_codigo;
      option.textContent = bodega.bode_nombre;
      bodegaSelect.appendChild(option);
    });
  } catch (error) {
    console.error("Error al cargar bodegas:", error);
    bodegaSelect.innerHTML = '<option value="">Error al cargar</option>';
  }
}

async function loadSucursales(bodeCodigo) {
  const sucursalSelect = document.getElementById("sucursal");
  sucursalSelect.innerHTML = '<option value="">Cargando...</option>';

  if (!bodeCodigo) {
    sucursalSelect.innerHTML =
      '<option value="">Seleccione una bodega primero</option>';
    return;
  }

  try {
    const response = await fetch(
      `get_sucursales.php?bode_codigo=${bodeCodigo}`,
    );
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const sucursales = await response.json();

    if (sucursales.error) {
      alert("Error cargando sucursales: " + sucursales.error);
      sucursalSelect.innerHTML = '<option value="">Error</option>';
      return;
    }

    if (sucursales.length === 0) {
      sucursalSelect.innerHTML =
        '<option value="">No hay sucursales disponibles</option>';
      return;
    }

    sucursalSelect.innerHTML = '<option value="" ></option>';
    sucursales.forEach((sucursal) => {
      const option = document.createElement("option");
      option.value = sucursal.sucu_codigo;
      option.textContent = sucursal.sucu_nombre;
      sucursalSelect.appendChild(option);
    });
  } catch (error) {
    console.error("Error al cargar sucursales:", error);
    sucursalSelect.innerHTML = '<option value="">Error al cargar</option>';
  }
}

async function loadMoneda() {
  const monedaSelect = document.getElementById("moneda");

  monedaSelect.innerHTML = '<option value="">Cargando monedas...</option>';

  try {
    const response = await fetch("get_monedas.php");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }
    const monedas = await response.json();

    monedaSelect.innerHTML = '<option value="" selected></option>';

    if (monedas.error) {
      alert("Error cargando monedas: " + monedas.error);
      return;
    }

    monedas.forEach((moneda) => {
      const option = document.createElement("option");
      option.value = moneda.mone_codigo;
      option.textContent = moneda.mone_nombre;
      monedaSelect.appendChild(option);
    });
  } catch (error) {
    console.error("Error al cargar bodegas:", error);
    monedaSelect.innerHTML = '<option value="">Error al cargar</option>';
  }
}

document.addEventListener("DOMContentLoaded", function () {
  loadBodegas();
  loadMoneda();
  const bodegaSelect = document.getElementById("bodega");
  bodegaSelect.addEventListener("change", function () {
    const selectedBodega = this.value;
    loadSucursales(selectedBodega);
  });

  const submitBtn = document.querySelector(".submit-btn");
  submitBtn.addEventListener("click", async function () {
    const form = document.querySelector("form");
    const formData = new FormData(form);

    const codigo = formData.get("codigo").trim();
    const nombre = formData.get("nombre").trim();
    const bodega = formData.get("bodega");
    const sucursal = formData.get("sucursal");
    const moneda = formData.get("moneda");
    const precio = formData.get("precio").trim();
    const descripcion = formData.get("descripcion").trim();
    const materiales = document.querySelectorAll(
      'input[name="material[]"]:checked',
    );

    if (!codigo) {
      alert("El código del producto no puede estar en blanco.");
      return;
    } else {
      const codigoRegex = /^[a-zA-Z0-9]+$/;
      if (!codigoRegex.test(codigo)) {
        alert("El código del producto solo debe contener letras y números.");
        return;
      }

      if (codigo.length < 5 || codigo.length > 15) {
        alert("El código del producto debe tener entre 5 y 15 caracteres.");
        return;
      }

      try {
        const checkResponse = await fetch("exist.php", {
          method: "POST",
          headers: {
            "Content-Type": "application/json",
          },
          body: JSON.stringify({ codigo: codigo }),
        });
        const checkResult = await checkResponse.json();

        if (checkResult.exists) {
          alert("El código del producto ya está registrado.");
          return;
        }
      } catch (error) {
        console.error("Error validando código:", error);
        alert("Error al validar el código del producto.");
        return;
      }
    }

    if (!nombre) {
      alert("El nombre del producto no puede estar en blanco.");
      return;
    } else {
      if (nombre.length < 2 || nombre.length > 50) {
        alert("El nombre del producto debe tener entre 2 y 50 caracteres.");
        return;
      }
    }

    if (!bodega) {
      alert("Debe seleccionar una bodega.");
      return;
    }

    if (!sucursal) {
      alert("Debe seleccionar una sucursal para la bodega seleccionada.");
      return;
    }

    if (!moneda) {
      alert("Debe seleccionar una moneda para el producto.");
      return;
    }

    if (!precio) {
      alert("El precio del producto no puede estar en blanco.");
      return;
    } else {
      const precioRegex = /^\d+(\.\d{1,2})?$/;
      if (!precioRegex.test(precio)) {
        alert(
          "El precio debe ser un número positivo, con hasta dos decimales.",
        );
        return;
      }
    }

    if (!descripcion) {
      alert("La descripción del producto no puede estar en blanco.");
      return;
    } else {
      if (descripcion.length < 10 || descripcion.length > 1000) {
        alert(
          "La descripción del producto debe tener entre 10 y 1000 caracteres.",
        );
        return;
      }
    }

    if (materiales.length < 2) {
      alert("Debe seleccionar al menos dos materiales para el producto.");
      return;
    }

    const precioInt = parseFloat(precio);
    formData.set("precio", precioInt);

    try {
      const response = await fetch("insert_product.php", {
        method: "POST",
        body: formData,
      });

      if (!response.ok) {
        throw new Error(`HTTP error! status: ${response.status}`);
      }

      const result = await response.json();

      if (result.error) {
        alert("Error: " + result.error);
      } else {
        alert(result.message);
        form.reset();
      }
    } catch (error) {
      console.error("Error al guardar el producto:", error);
      alert("Hubo un problema al intentar guardar el producto.");
    }
  });
});
