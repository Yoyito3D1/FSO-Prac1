# Comparador de Fitxers i Directoris (Python + Bash)

Aquest projecte combina Python i Bash per comparar dos fitxers o dos directoris, i crear un nou directori a partir d'un fitxer de registre (`recents.log`). El resultat de la comparació es desa al fitxer `resultat/resultatDir.txt`.

---

## 📁 Estructura del projecte

```
.
├── comparador.py           # Script principal en Python
├── compfitxer.sh           # Compara fitxers línia a línia
├── comptot.sh              # Compara directoris i subdirectoris
├── tipus.sh                # Determina si un camí és fitxer o directori
├── crearnou.sh             # Crea un directori nou a partir de recents.log
├── recents.log             # Fitxer amb informació de fitxers/directoris recents
├── resultat/
│   └── resultatDir.txt     # Fitxer amb els resultats de la comparació
```

---

## ▶️ Execució

Per executar el programa principal:

```bash
python3 comparador.py <ruta1> <ruta2> <directori_nou>
```

### Exemples

- Comparar dos fitxers:

```bash
python3 comparador.py arxiu1.txt arxiu2.txt noudir
```

- Comparar dos directoris:

```bash
python3 comparador.py carpeta1 carpeta2 noudir
```

---

## ⚙️ Funcionament

- El script **comprova que hi hagi exactament 3 arguments**.
- El primer i segon arguments han de ser del **mateix tipus** (fitxer o directori).
- En funció del tipus:
  - Si són fitxers: executa `compfitxer.sh`
  - Si són directoris: executa `comptot.sh`
- El directori especificat com a tercer argument es **reinicia si ja existeix**.
- Es genera un nou directori amb `crearnou.sh` a partir del contingut de `recents.log`.
- El fitxer `resultat/resultatDir.txt` es buida i s'utilitza per guardar el resultat de la comparació.

---

## 📌 Scripts rellevants

### `comparador.py` (Python)
- Gestiona els arguments i decideix quin script Bash executar.
- S'encarrega d'esborrar fitxers/directoris previs per començar en net.

### `tipus.sh`
- Determina si una ruta és:
  - 1 → fitxer
  - 2 → directori
  - altra → error

### `compfitxer.sh`
- Compara dues rutes si són fitxers.
- Escriu diferències al `resultatDir.txt`.

### `comptot.sh`
- Compara el contingut de dos directoris recursivament.

### `crearnou.sh`
- Crea un nou directori i hi copia informació basada en `recents.log`.

---

## 📂 Fitxers de sortida

El fitxer `resultat/resultatDir.txt` inclou el resultat de la comparació entre:
- Línies (si són fitxers)
- Estructura i contingut (si són directoris)

---

## 🧪 Validacions i errors gestionats

- Error si no s’introdueixen 3 arguments exactes.
- Error si es vol comparar un fitxer amb un directori.
- Els fitxers i directoris es netegen abans d’executar el procés.

---

## 👨‍💻 Autor

Pràctica realitzada com a part d’una assignatura per practicar:

- Integració entre Python i Bash
- Tractament de fitxers i directoris
- Automatització i processament de dades
