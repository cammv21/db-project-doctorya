import requests
import datetime
import pandas as pd
import streamlit as st

with open('styles.css') as f:
    css = f.read()
    st.markdown(f'<style>{css}</style>', unsafe_allow_html=True)

st.title("Proyecto Doctor Ya")

tab1, tab2 = st.tabs(["Pacientes","Doctores"])
api_clientes = "http://localhost:3000/paciente"
api_medicos = "http://localhost:3000/medico"

# Obtenemos los pacientes
try:
    response = requests.get(api_clientes)  # Cambia la URL según sea necesario
    response.raise_for_status()  # Lanza una excepción si la respuesta tiene un error HTTP
    pacientes = response.json()  # Parsear la respuesta como JSON

    # Mostrar los datos en Streamlit
    if isinstance(pacientes, list) and pacientes:
        listadoClinetes = pd.DataFrame(pacientes)
        listadoClinetes.columns = [col[2:].capitalize() for col in listadoClinetes.columns]
        listadoClinetes['Fecha_nacimiento'] = pd.to_datetime(listadoClinetes['Fecha_nacimiento']).dt.date
    else:
        st.warning("No hay pacientes para mostrar o la respuesta no es una lista.")
except requests.exceptions.RequestException as e:
        st.error(f"Error al conectar con la API: {e}")

# Obtenemos los medicos
try:
    response = requests.get(api_medicos)  # Cambia la URL según sea necesario
    response.raise_for_status()  # Lanza una excepción si la respuesta tiene un error HTTP
    medicos = response.json()  # Parsear la respuesta como JSON

    # Mostrar los datos en Streamlit
    if isinstance(medicos, list) and medicos:
        listadoMedicos = pd.DataFrame(medicos)
        listadoMedicos.columns = [col[2:].capitalize() for col in listadoMedicos.columns]
    else:
        st.warning("No hay medicos para mostrar o la respuesta no es una lista.")
except requests.exceptions.RequestException as e:
        st.error(f"Error al conectar con la API: {e}")

#--- TAB Pacientes ---
with tab1:
    # --- CREAR PACIENTE ---
    st.subheader("Crear un paciente:")

    col1, col2, col3, col4, col5, col6, col7 = st.columns(7)
    # Columnas de los datos a actulizar
    with col1:
        nombre = st.text_input("Nombre",key=0)
    with col2:
        identificacion = st.text_input("Identificacion",key=1)
    with col3:
        fechaN = st.date_input("Fecha de Nacimiento",key=2)
    with col4:
        sexo = st.selectbox("Sexo",("M","F"),key=3)
    with col5:
        direccion = st.text_input("Direccion",key=4)
    with col6:
        email = st.text_input("Email",key=5)
    with col7:
        celular = st.text_input("Celular",key=6)

    if st.button("Crear Paciente"):
        # Validar campos requeridos
        if not nombre or not identificacion or not fechaN or not sexo:
            st.error("Por favor, completa todos los campos requeridos.")
        else:
            # Estructura del cuerpo del POST
            payload = {
                "nombre": nombre,
                "identificacion": identificacion,
                "fecha_nacimiento": fechaN.isoformat(),  # Convertir a formato ISO
                "sexo": sexo,
                "direccion": direccion,
                "email": email,
                "celular": celular
            }

            try:
                response = requests.post(api_clientes, json=payload)
                
                if response.status_code == 201:
                    st.success("Paciente agregado exitosamente.")
                else:
                    st.error(f"Error al agregar el paciente: {response.status_code} - {response.text}")
            except requests.exceptions.RequestException as e:
                st.error(f"Error de conexión: {e}")

    # --- MODIFICAR PACIENTE ---
    st.subheader("Modificar un paciente:")

    # Inicializar estado persistente
    if "bandera" not in st.session_state:
        st.session_state.bandera = False
    if "indiceTabla" not in st.session_state:
        st.session_state.indiceTabla = -1
    if "count" not in st.session_state:
        st.session_state.count = False

    col1, col2, col3 = st.columns([1, 0.5, 6])

    with col1:
        p_id = st.text_input("Id del paciente a cambiar")
    with col2:
        st.markdown("<div style='margin-top: 1.6rem; text-align: center;'>", unsafe_allow_html=True)
        if st.button("Buscar"):
            st.session_state.count = True
            if p_id.isdigit() and int(p_id) in listadoClinetes.iloc[:, 0].values:
                st.session_state.bandera = True
                st.session_state.indiceTabla = listadoClinetes[listadoClinetes.iloc[:, 0] == int(p_id)].index[0]
            else:
                st.session_state.bandera = False

    with col3:
        if not st.session_state.bandera and st.session_state.count:
            st.markdown("<div style='margin-top: 1rem; text-align: center;'>", unsafe_allow_html=True)
            st.error("Paciente no encontrado")

    # Mostrar los campos solo si se encontró un paciente
    if st.session_state.bandera:
        st.divider()
        col1, col2, col3, col4, col5, col6, col7= st.columns(7)

        with col1:
            nombre = st.text_input("Nombre", value=listadoClinetes.iloc[st.session_state.indiceTabla, 1])
        with col2:
            identificacion = st.text_input("Identificacion", value=listadoClinetes.iloc[st.session_state.indiceTabla, 2])
        with col3:
            fechaN = st.date_input("Fecha de Nacimiento", value=pd.to_datetime(listadoClinetes.iloc[st.session_state.indiceTabla, 3]))
        with col4:
            numero = 1 if listadoClinetes.iloc[st.session_state.indiceTabla, 4] == "F" else 0
            sexo = st.selectbox("Sexo", ("M", "F"), index=numero)
        with col5:
            direccion = st.text_input("Direccion", value=listadoClinetes.iloc[st.session_state.indiceTabla, 5])
        with col6:
            email = st.text_input("Email", value=listadoClinetes.iloc[st.session_state.indiceTabla, 6])
        with col7:
            celular = st.text_input("Celular", value=listadoClinetes.iloc[st.session_state.indiceTabla, 7])

        if st.button("Modificar Paciente"):
            # Validar campos requeridos
            if not nombre or not identificacion or not fechaN or not sexo:
                st.error("Por favor, completa todos los campos requeridos.")
            else:
                # Estructura del cuerpo del POST
                payload = {
                    "nombre": nombre,
                    "identificacion": identificacion,
                    "fecha_nacimiento": fechaN.isoformat(),
                    "sexo": sexo,
                    "direccion": direccion,
                    "email": email,
                    "celular": celular
                }
                try:
                    response = requests.patch(f"{api_clientes}/{p_id}", json=payload)

                    # Manejar respuesta
                    if response.status_code == 200:
                        st.session_state.indiceTabla = 0
                        st.success("Paciente modificado exitosamente.")
                    else:
                        st.error(f"Error al modificar el paciente: {response.status_code} - {response.text}")
                except requests.exceptions.RequestException as e:
                    st.error(f"Error de conexión: {e}")

    # --- BORRAR PACIENTE ---
    st.subheader("Eliminar un paciente:")
    bandera2 = False; indiceTabla2 = 0; count2 = False
    col1, col2, col3 = st.columns([1,0.6,6])
    with col1:
        p_id2 = st.text_input("Id del paciente a borrar")
    with col2:
        st.markdown("<div style='margin-top: 2rem; text-align: center;'>", unsafe_allow_html=True)  # Ajuste de alineación
        if st.button("Eliminar",key=""):
            count2 = True
            if int(p_id2) in listadoClinetes.iloc[:, 0].values:
                bandera2 = True; 
                try:
                    responseD = requests.delete(api_clientes+f"/{p_id2}")
                except requests.exceptions.RequestException as e:
                    st.error(f"Error de conexión: {e}")
    with col3:
        if not bandera2 and count2:
            st.markdown("<div style='margin-top: 1rem; text-align: center;'>", unsafe_allow_html=True)
            st.error("No se pudo borrar el paciente")
        elif bandera2:
            st.markdown("<div style='margin-top: 1rem; text-align: center;'>", unsafe_allow_html=True)
            st.success("Paciente borrado exitosamente.")
        st.write("")
                

    # --- OBTENER PACIENTE ---
    col1, col2 = st.columns([1,3.4])
    with col1:
        st.subheader("Obtener los pacientes:")
    with col2:
        if st.button("Actualizar"):
            st.rerun()

    st.dataframe(listadoClinetes, use_container_width=True,hide_index=True) 

# --- TAB Medicos ---
with tab2:
    # --- CREAR MEDICO ---
    st.subheader("Crear un medico:")

    col1, col2, col3, col4, col5, col6 = st.columns(6)
    # Columnas de los datos a actulizar
    with col1:
        nombre = st.text_input("Nombre",key=7)
    with col2:
        identificacion = st.text_input("Identificacion",key=8)
    with col3:
        registroMedico = st.text_input("Registro Medico",key=9)
    with col4:
        especialidad = st.text_input("Especialidad",key=10)
    with col5:
        email = st.text_input("Email",key=12)
    with col6:
        celular = st.text_input("Celular",key=13)

    if st.button("Crear Medico"):
        # Validar campos requeridos
        if not nombre or not identificacion or not especialidad or not registroMedico:
            st.error("Por favor, completa todos los campos requeridos.")
        else:
            # Estructura del cuerpo del POST
            payload = {
                "nombre": nombre,
                "identificacion": identificacion,
                "registro_medico": registroMedico, 
                "especialidad": especialidad,
                "email": email,
                "celular": celular
            }

            try:
                response = requests.post(api_medicos, json=payload)
                
                if response.status_code == 201:
                    st.success("Medico agregado exitosamente.")
                else:
                    st.error(f"Error al agregar el medico: {response.status_code} - {response.text}")
            except requests.exceptions.RequestException as e:
                st.error(f"Error de conexión: {e}")

    # --- MODIFICAR MEDICO ---
    st.subheader("Modificar un medico:")

    # Inicializar estado persistente
    if "bandera" not in st.session_state:
        st.session_state.bandera = False
    if "indiceTabla" not in st.session_state:
        st.session_state.indiceTabla = -1
    if "count" not in st.session_state:
        st.session_state.count = False

    col1, col2, col3 = st.columns([1, 0.5, 6])

    with col1:
        p_id = st.text_input("Id del medico a cambiar")
    with col2:
        st.markdown("<div style='margin-top: 1.6rem; text-align: center;'>", unsafe_allow_html=True)
        if st.button("Buscar",key="b"):
            st.session_state.count = True
            if p_id.isdigit() and int(p_id) in listadoMedicos.iloc[:, 0].values:
                st.session_state.bandera = True
                st.session_state.indiceTabla = listadoMedicos[listadoMedicos.iloc[:, 0] == int(p_id)].index[0]
            else:
                st.session_state.bandera = False

    with col3:
        if not st.session_state.bandera and st.session_state.count:
            st.markdown("<div style='margin-top: 1rem; text-align: center;'>", unsafe_allow_html=True)
            st.error("Medico no encontrado")

    # Mostrar los campos solo si se encontró un medico
    if st.session_state.bandera:
        st.divider()
        col1, col2, col3, col4, col5, col6= st.columns(6)

        with col1:
            nombre = st.text_input("Nombre", value=listadoMedicos.iloc[st.session_state.indiceTabla, 1])
        with col2:
            identificacion = st.text_input("Identificacion", value=listadoMedicos.iloc[st.session_state.indiceTabla, 2])
        with col3:
            registroMedico = st.text_input("Registro Medico", value=listadoMedicos.iloc[st.session_state.indiceTabla, 3])
        with col4:
            especialidad = st.text_input("Especialidad", value=listadoMedicos.iloc[st.session_state.indiceTabla, 4])
        with col5:
            email = st.text_input("Email", value=listadoMedicos.iloc[st.session_state.indiceTabla, 5])
        with col6:
            celular = st.text_input("Celular", value=listadoMedicos.iloc[st.session_state.indiceTabla, 6])

        if st.button("Modificar Medico"):
            # Validar campos requeridos
            if not nombre or not identificacion or not especialidad or not registroMedico:
                st.error("Por favor, completa todos los campos requeridos.")
            else:
                # Estructura del cuerpo del POST
                payload = {
                    "nombre": nombre,
                    "identificacion": identificacion,
                    "registro_medico": registroMedico, 
                    "especialidad": especialidad,
                    "email": email,
                    "celular": celular
                }
                try:
                    response = requests.patch(f"{api_medicos}/{p_id}", json=payload)

                    # Manejar respuesta
                    if response.status_code == 200:
                        st.session_state.indiceTabla = 0
                        st.success("Medico modificado exitosamente.")
                    else:
                        st.error(f"Error al modificar el medico: {response.status_code} - {response.text}")
                except requests.exceptions.RequestException as e:
                    st.error(f"Error de conexión: {e}")

    # --- BORRAR MEDICO ---
    st.subheader("Eliminar un medico:")
    bandera2 = False; indiceTabla2 = 0; count2 = False
    col1, col2, col3 = st.columns([1,0.6,6])
    with col1:
        p_id2 = st.text_input("Id del medico a borrar")
    with col2:
        st.markdown("<div style='margin-top: 2rem; text-align: center;'>", unsafe_allow_html=True)  # Ajuste de alineación
        if st.button("Eliminar",key="c"):
            count2 = True
            if int(p_id2) in listadoMedicos.iloc[:, 0].values:
                bandera2 = True; 
                try:
                    responseD = requests.delete(api_medicos+f"/{p_id2}")
                except requests.exceptions.RequestException as e:
                    st.error(f"Error de conexión: {e}")
    with col3:
        if not bandera2 and count2:
            st.markdown("<div style='margin-top: 1rem; text-align: center;'>", unsafe_allow_html=True)
            st.error("No se pudo borrar el medico")
        elif bandera2:
            st.markdown("<div style='margin-top: 1rem; text-align: center;'>", unsafe_allow_html=True)
            st.success("Medico borrado exitosamente.")
        st.write("")
                

    # --- OBTENER MEDICO ---
    col1, col2 = st.columns([1,3.4])
    with col1:
        st.subheader("Obtener los medicos:")
    with col2:
        if st.button("Actualizar",key="d"):
            st.experimental_rerun()

    st.dataframe(listadoMedicos, use_container_width=True,hide_index=True) 