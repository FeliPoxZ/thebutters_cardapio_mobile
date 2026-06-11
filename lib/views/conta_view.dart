import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:thebutters_cardapio_mobile/controllers/login_controller.dart';
import 'package:thebutters_cardapio_mobile/core/theme/app_colors.dart';
import 'package:thebutters_cardapio_mobile/services/usuario_service.dart';

class ContaView extends StatefulWidget {
  const ContaView({super.key});

  @override
  State<ContaView> createState() => _ContaViewState();
}

class _ContaViewState extends State<ContaView> {
  final controller = GetIt.I<LoginController>();
  final _usuarioService = GetIt.I<UsuarioService>();

  @override
  void initState() {
    super.initState();
    controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    final statusBar = MediaQuery.of(context).padding.top;
    final nome = _usuarioService.nome;
    final email = _usuarioService.email;
    final telefone = _usuarioService.telefone;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(243, 236, 222, 1),
      body: Stack(
        children: [
          Column(
            children: [
              // ── HEADER ──────────────────────────────────────────────
              Container(
                color: AppColors.banner, // mesmo laranja do cardápio
                padding: EdgeInsets.only(
                  top: statusBar + 12,
                  bottom: 24,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Minha Conta',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Divider(thickness: 4, height: 4, color: AppColors.secondary),

              // ── CONTEÚDO ─────────────────────────────────────────────
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Avatar + nome
                      Center(
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 44,
                              backgroundColor: AppColors.secondary,
                              child: const Icon(
                                Icons.person,
                                size: 48,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              nome ?? '—',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // ── CARD DE DADOS ─────────────────────────────────
                      _SectionCard(
                        title: 'Dados pessoais',
                        children: [
                          _InfoTile(
                            icon: Icons.person_outline,
                            label: 'Nome',
                            value: nome ?? '—',
                          ),
                          const _Divider(),
                          _InfoTile(
                            icon: Icons.email_outlined,
                            label: 'E-mail',
                            value: email ?? '—',
                          ),
                          const _Divider(),
                          _InfoTile(
                            icon: Icons.phone_outlined,
                            label: 'Telefone',
                            value: telefone ?? '—',
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // ── CARD DE AÇÕES ──────────────────────────────────
                      _SectionCard(
                        title: 'Conta',
                        children: [
                          _ActionTile(
                            icon: Icons.lock_outline,
                            label: 'Alterar senha',
                            onTap: () =>
                                Navigator.pushNamed(context, 'AlterarSenha'),
                          ),
                          const _Divider(),
                          _ActionTile(
                            icon: Icons.edit_outlined,
                            label: 'Editar perfil',
                            onTap: () =>
                                Navigator.pushNamed(context, 'EditarPerfil'),
                          ),
                        ],
                      ),

                      const SizedBox(height: 32),

                      // ── BOTÃO LOGOUT ───────────────────────────────────
                      ElevatedButton.icon(
                        onPressed: controller.carregando
                            ? null
                            : () => controller.logout(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(28, 99, 178, 1),
                          minimumSize: const Size.fromHeight(56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.logout, color: Colors.white),
                        label: const Text(
                          'SAIR DA CONTA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── LOADING OVERLAY (mesmo padrão do LoginView) ──────────────
          if (controller.carregando)
            Container(
              color: Colors.black45,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(253, 247, 237, 1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(28, 99, 178, 1),
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Saindo...',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
//  WIDGETS AUXILIARES
// ─────────────────────────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _SectionCard({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
              letterSpacing: 0.5,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(253, 247, 237, 1),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(icon, color: AppColors.extraOrange, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 11, color: Colors.black45),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Icon(icon, color: AppColors.extraOrange, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.black38),
          ],
        ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 1,
      thickness: 1,
      indent: 52,
      color: Color.fromARGB(255, 225, 220, 210),
    );
  }
}
