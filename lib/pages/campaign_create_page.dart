import 'package:crowdfunding_app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:crowdfunding_app/widgets/file_upload.dart';
import 'package:crowdfunding_app/widgets/image_upload.dart';

class CampaignCreatePage extends StatefulWidget {
  const CampaignCreatePage({super.key});

  @override
  State<CampaignCreatePage> createState() => _CampaignCreatePageState();
}

class _CampaignCreatePageState extends State<CampaignCreatePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  DateTime? _startDate;
  DateTime? _endDate;

  Future<void> _pickDate(BuildContext context, bool isStartDate) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _endDate = pickedDate;
        }
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_startDate == null || _endDate == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Хоёр огноог сонгоно уу')));
        return;
      }
      // TODO: Handle form submission
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Хандивын аян үүсгэх',
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTextField(_titleController, 'Гарчиг', Icons.title),
                _buildTextField(
                  _descriptionController,
                  'Тайлбар',
                  Icons.description,
                  maxLines: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _buildDatePicker('Эхлэх', _startDate, true),
                    ),
                    const SizedBox(
                      width: 10,
                    ), // Add spacing between the two date pickers
                    Expanded(
                      child: _buildDatePicker('Дуусах', _endDate, false),
                    ),
                  ],
                ),
                _buildTextField(
                  _amountController,
                  'Мөнгөн дүн',
                  Icons.attach_money,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: _submitForm,
                  child: const Center(
                    child: Text(
                      'Хүсэлт илгээх',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const FileUploadWidget(),
                const ImageUploadWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    IconData icon, {
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: MyColors.primary),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        validator: (value) => value!.isEmpty ? '$label оруулна уу!' : null,
      ),
    );
  }

  Widget _buildDatePicker(
    String label,
    DateTime? selectedDate,
    bool isStartDate,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.grey[100],
        leading: const Icon(Icons.calendar_today, color: MyColors.primary),
        title: Text(
          selectedDate == null ? label : '${_formatDate(selectedDate)}',
          style: const TextStyle(fontSize: 16),
        ),
        onTap: () => _pickDate(context, isStartDate),
      ),
    );
  }
}
