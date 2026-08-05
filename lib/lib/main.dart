import 'package:flutter/material.dart';

void main() {
  runApp(const PowerFit());
}

class PowerFit extends StatelessWidget {
  const PowerFit({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "PowerFit",
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 113, 14, 7),
          brightness: Brightness.dark,
        ),
      ),
      home: const TelaInicial(),
    );
  }
}

List<Map<String, dynamic>> exercicios = [];

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("🏋🏽‍♀️", style: TextStyle(fontSize: 90)),
              const SizedBox(height: 20),
              const Text(
                "POWERFIT",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                "Seu treino começa aqui!",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 113, 14, 7),
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 55),
                ),
                icon: const Icon(Icons.fitness_center),
                label: const Text("COMEÇAR", style: TextStyle(fontSize: 18)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const TreinosPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TreinosPage extends StatefulWidget {
  const TreinosPage({super.key});

  @override
  State<TreinosPage> createState() => _TreinosPageState();
}

class _TreinosPageState extends State<TreinosPage> {
  void atualizar() {
    setState(() {});
  }

  void excluir(int index) {
    setState(() {
      exercicios.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("💪 Meus Treinos"),
        backgroundColor: const Color.fromARGB(255, 113, 14, 7),
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const HistoricoPage()),
              ).then((_) => atualizar());
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 113, 14, 7),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CadastroPage()),
          );

          atualizar();
        },
      ),
      body: exercicios.isEmpty
          ? const Center(
              child: Text(
                "🏋🏽‍♀️Nenhum exercício cadastrado!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              itemCount: exercicios.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    leading: Checkbox(
                      value: exercicios[index]["concluido"],
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          exercicios[index]["concluido"] = value!;
                        });
                      },
                    ),
                    title: Text(
                      " ${exercicios[index]["nome"]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: exercicios[index]["concluido"]
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" ${exercicios[index]["grupo"]}"),
                        Text(" ${exercicios[index]["series"]} séries"),
                        Text(" ${exercicios[index]["repeticoes"]} repetições"),
                        Text(" ${exercicios[index]["carga"]} kg"),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: const Color.fromARGB(255, 113, 14, 7),
                      ),
                      onPressed: () => excluir(index),
                    ),
                  ),
                );
              },
            ),
    );
  }
}

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final nome = TextEditingController();
  final grupo = TextEditingController();
  final series = TextEditingController();
  final repeticoes = TextEditingController();
  final carga = TextEditingController();
  @override
  void dispose() {
    nome.dispose();
    grupo.dispose();
    series.dispose();
    repeticoes.dispose();
    carga.dispose();
    super.dispose();
  }

  void salvar() {
    if (nome.text.isEmpty ||
        grupo.text.isEmpty ||
        series.text.isEmpty ||
        repeticoes.text.isEmpty ||
        carga.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos!"),
          backgroundColor: const Color.fromARGB(255, 113, 14, 7),
        ),
      );
      return;
    }

    exercicios.add({
      "nome": nome.text,
      "grupo": grupo.text,
      "series": series.text,
      "repeticoes": repeticoes.text,
      "carga": carga.text,
      "concluido": false,
    });

    Navigator.pop(context);
  }

  Widget campo(
    TextEditingController controller,
    String texto,
    IconData icone,
    TextInputType tipo,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        controller: controller,
        keyboardType: tipo,
        decoration: InputDecoration(
          prefixIcon: Icon(icone, color: const Color.fromARGB(255, 113, 14, 7)),
          labelText: texto,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("➕ Novo Exercício"),
        backgroundColor: const Color.fromARGB(255, 113, 14, 7),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            campo(
              nome,
              "Nome do Exercício",
              Icons.fitness_center,
              TextInputType.text,
            ),
            campo(
              grupo,
              "Grupo Muscular",
              Icons.sports_gymnastics,
              TextInputType.text,
            ),
            campo(
              series,
              "Séries",
              Icons.format_list_numbered,
              TextInputType.number,
            ),
            campo(repeticoes, "Repetições", Icons.repeat, TextInputType.number),
            campo(
              carga,
              "Carga (kg)",
              Icons.monitor_weight,
              TextInputType.number,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: salvar,
                icon: const Icon(Icons.save),
                label: const Text("Salvar 💪", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 113, 14, 7),
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HistoricoPage extends StatelessWidget {
  const HistoricoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📂 Histórico"),
        backgroundColor: const Color.fromARGB(255, 113, 14, 7),
        foregroundColor: Colors.white,
      ),
      body: exercicios.isEmpty
          ? const Center(
              child: Text(
                "📭 Nenhum exercício salvo!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: exercicios.length,
              itemBuilder: (context, index) {
                final exercicio = exercicios[index];

                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: Icon(
                      exercicio["concluido"]
                          ? Icons.check_circle
                          : Icons.radio_button_unchecked,
                      color: exercicio["concluido"]
                          ? Colors.green
                          : Colors.grey,
                    ),
                    title: Text(
                      " ${exercicio["nome"]}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" ${exercicio["grupo"]}"),
                        Text(
                          " ${exercicio["series"]} séries | 🏅 ${exercicio["repeticoes"]} repetições",
                        ),
                        Text(" ${exercicio["carga"]} kg"),
                        const SizedBox(height: 5),
                        Text(
                          exercicio["concluido"] ? " Concluído" : " Pendente",
                          style: TextStyle(
                            color: exercicio["concluido"]
                                ? Colors.green
                                : Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
