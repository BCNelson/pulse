import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

const graphQLEndpoint = String.fromEnvironment(
  'GRAPHQL_ENDPOINT',
  defaultValue: 'http://127.0.0.1:8080/graphql',
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();

  final client = ValueNotifier(
    GraphQLClient(
      link: HttpLink(graphQLEndpoint),
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(PulseApp(client: client));
}

class PulseApp extends StatelessWidget {
  const PulseApp({super.key, required this.client});

  final ValueNotifier<GraphQLClient> client;

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp(
        title: 'Pulse',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B7F79)),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const healthQuery = '''
    query Health {
      health
      serverTime
    }
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pulse')),
      body: Center(
        child: Query(
          options: QueryOptions(
            document: gql(healthQuery),
            pollInterval: const Duration(seconds: 10),
          ),
          builder: (result, {fetchMore, refetch}) {
            if (result.isLoading && result.data == null) {
              return const CircularProgressIndicator();
            }

            final error = result.exception;
            if (error != null) {
              return StatusPanel(
                title: 'API unavailable',
                subtitle: error.toString(),
                onRefresh: refetch,
              );
            }

            final data = result.data ?? {};
            return StatusPanel(
              title: 'API ${data['health'] ?? 'unknown'}',
              subtitle: 'Server time: ${data['serverTime'] ?? '-'}',
              onRefresh: refetch,
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
  final Future<QueryResult<Object?>> Function()? onRefresh;

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
            onPressed: onRefresh == null ? null : () => onRefresh!(),
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
