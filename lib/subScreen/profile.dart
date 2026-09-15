import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/amount_provider.dart';
import '../screens/login_page.dart';
import 'package:flutter/services.dart';

class Profile extends ConsumerStatefulWidget {
  const Profile({super.key});

  @override
  ConsumerState<Profile> createState() => _ProfileState();
}

class _ProfileState extends ConsumerState<Profile> {
  // Starting on Profile to show the requested UI

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: const ProfilePage());
  }
}

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  final TextEditingController _budgetController = TextEditingController(
    text: '0',
  );
  final TextEditingController _amountController = TextEditingController(
    text: "100",
  );

  final TextEditingController _currencyController = TextEditingController(
    text: "",
  );
  int _currentSpent = 1300;

  @override
  Widget build(BuildContext context) {
    
    double _totalBudget = ref.watch(budgetProvider);
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // 2. Main Content Area
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Budget Progress Ring Card
                    _buildProgressCard(),
                    const SizedBox(height: 20),

                    // Set Budget Card
                    _buildSetBudgetCard(),
                    const SizedBox(height: 24),

                    _buildSetCurrency(),
                    const SizedBox(height: 24),

                    // Settings List
                    _buildSettingsList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- UI Components ---

  Widget _buildProgressCard() {
    double _totalBudget = ref.watch(budgetProvider);
    double progress = _currentSpent / _totalBudget;
    final currency = ref.watch(currencyProvier);
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SizedBox(
        height: 200,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background Ring
            SizedBox(
              width: 160,
              height: 160,
              child: CircularProgressIndicator(
                value: 1.0,
                strokeWidth: 12,
                backgroundColor: const Color(0xFFE8DEF8),
                strokeCap: StrokeCap.round,
              ),
            ),
            // Foreground Progress Ring
            SizedBox(
              width: 160,
              height: 160,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 12,
                color: const Color(0xFF7E57C2),
                strokeCap: StrokeCap.round,
                backgroundColor: Colors.transparent,
              ),
            ),
            // Center Text
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$currency ${_currentSpent.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '/ $currency ${_totalBudget.toStringAsFixed(0)}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetBudgetCard() {
    final currency = ref.watch(currencyProvier);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Set Budget',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _budgetController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    prefixText: '$currency ',
                    prefixStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    hintText: '0.00',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle save logic here
                  setState(() {
                    ref.read(budgetProvider.notifier).state =
                        double.tryParse(
                          _budgetController.text.replaceAll(',', ''),
                        ) ??
                        0;
                  });
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Success"),
                      content: const Text("Amount saved successfully!"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7E57C2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSetCurrency() {
    final currency = ref.watch(currencyProvier);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Set Currency',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: TextField(
                  inputFormatters: [UpperCaseLetterFormatter()],
                  controller: _currencyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    
                    hintText: "$currency",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  // Handle save logic here
                  setState(() {
                    ref.read(currencyProvier.notifier).state =
                        _currencyController.text;
                  });
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Success"),
                      content: const Text(
                        "Currency Format saved successfully!",
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7E57C2),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList() {
    final settings = [
      {'title': 'Account Settings', 'icon': Icons.settings_outlined},
      {'title': 'Notifications', 'icon': Icons.notifications_outlined},
      {'title': 'Privacy', 'icon': Icons.lock_outline},
      {'title': 'Help', 'icon': Icons.help_outline},
      {
        'title': 'Manage Categories',
        'icon': Icons.category_outlined,
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        },
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: settings.map((item) {
          return ListTile(
            leading: Icon(item['icon'] as IconData, color: Colors.grey[700]),
            title: Text(
              item['title'] as String,
              style: const TextStyle(fontSize: 16),
            ),
            trailing: Icon(Icons.chevron_right, color: Colors.grey[400]),
            onTap: item['onTap'] as void Function()?,
          );
        }).toList(),
      ),
    );
  }
}

class UpperCaseLetterFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String filtered = newValue.text.toUpperCase().replaceAll(
      RegExp(r'[^A-Z]'),
      '',
    ); // only A-Z
    if (filtered.length > 3) {
      filtered = filtered.substring(0, 3); // limit to 3 chars
    }
    return TextEditingValue(
      text: filtered,
      selection: TextSelection.collapsed(offset: filtered.length),
    );
  }
}
