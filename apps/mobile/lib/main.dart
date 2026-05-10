import 'package:ferry/ferry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_http_link/gql_http_link.dart';

import 'graphql/operations/__generated__/health.data.gql.dart';
import 'graphql/operations/__generated__/health.req.gql.dart';
import 'graphql/operations/__generated__/health.var.gql.dart';

const graphQLEndpoint = String.fromEnvironment(
  'GRAPHQL_ENDPOINT',
  defaultValue: 'http://127.0.0.1:8080/graphql',
);

final ferryClientProvider = Provider<Client>((ref) {
  final client = Client(link: HttpLink(graphQLEndpoint));
  ref.onDispose(client.dispose);
  return client;
});

final healthProvider =
    StreamProvider<OperationResponse<GHealthData, GHealthVars>>((ref) {
  final client = ref.watch(ferryClientProvider);
  return client.request(GHealthReq());
});

void main() {
  runApp(const ProviderScope(child: PulseApp()));
}

class PulseApp extends StatelessWidget {
  const PulseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pulse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B7F79)),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncResp = ref.watch(healthProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Pulse')),
      body: Center(
        child: asyncResp.when(
          loading: () => const CircularProgressIndicator(),
          error: (err, _) => StatusPanel(
            title: 'API unavailable',
            subtitle: err.toString(),
            onRefresh: () => ref.invalidate(healthProvider),
          ),
          data: (resp) {
            if (resp.hasErrors) {
              final errors = resp.graphqlErrors
                      ?.map((e) => e.message)
                      .join('\n') ??
                  resp.linkException?.toString() ??
                  'unknown error';
              return StatusPanel(
                title: 'API errors',
                subtitle: errors,
                onRefresh: () => ref.invalidate(healthProvider),
              );
            }
            final data = resp.data;
            return StatusPanel(
              title: 'API ${data?.health ?? "unknown"}',
              subtitle: 'Server time: ${data?.serverTime.value ?? "-"}',
              onRefresh: () => ref.invalidate(healthProvider),
            );
          },
        ),
      ),
    );
  }
}

class StatusPanel extends StatelessWidget {
  const StatusPanel({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onRefresh,
  });

  final String title;
  final String subtitle;
  final VoidCallback? onRefresh;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(subtitle, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          IconButton.filled(
            tooltip: 'Refresh',
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
