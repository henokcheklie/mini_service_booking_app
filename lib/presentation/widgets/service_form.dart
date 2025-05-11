import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mini_service_booking_app/core/constants.dart';
import 'package:mini_service_booking_app/core/utils/validators.dart';
import 'package:mini_service_booking_app/domain/entities/service.dart';
import 'package:mini_service_booking_app/presentation/controllers/service_controller.dart';
import 'package:mini_service_booking_app/presentation/widgets/custom_back_button.dart';
import 'package:mini_service_booking_app/presentation/widgets/custom_drop_down.dart';
import 'package:mini_service_booking_app/presentation/widgets/custom_switch_tile.dart';

class ServiceForm extends StatefulWidget {
  final Service? service;
  final ServiceController controller;
  final Function(Service) onSubmit;

  const ServiceForm({
    super.key,
    this.service,
    required this.onSubmit,
    required this.controller,
  });

  @override
  State<ServiceForm> createState() => _ServiceFormState();
}

class _ServiceFormState extends State<ServiceForm> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _priceController;
  late final TextEditingController _imageUrlController;
  late final TextEditingController _durationController;
  late final TextEditingController _ratingController;

  final RxString _selectedCategory = ''.obs;
  final RxString _selectedSubCategory = ''.obs;
  final RxBool _availability = true.obs;

  @override
  void initState() {
    super.initState();
    final service = widget.service;
    _selectedCategory.value = service?.category ?? 'Home Services';
    _selectedSubCategory.value = service?.name ?? 'Cleaning';
    _priceController =
        TextEditingController(text: service?.price.toString() ?? '');
    _imageUrlController = TextEditingController(
        text: service?.imageUrl ?? 'https://picsum.photos/200');
    _durationController =
        TextEditingController(text: service?.duration.toString() ?? '');
    _ratingController =
        TextEditingController(text: service?.rating.toString() ?? '');
    _availability.value = service?.availability ?? true;
  }

  @override
  void dispose() {
    _priceController.dispose();
    _imageUrlController.dispose();
    _durationController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final service = Service(
        id: widget.service?.id ?? '',
        name: _selectedSubCategory.value,
        category: _selectedCategory.value,
        price: double.parse(_priceController.text),
        imageUrl: _imageUrlController.text,
        availability: _availability.value,
        duration: int.parse(_durationController.text),
        rating: double.parse(_ratingController.text),
      );
      widget.onSubmit(service);
    }
  }

  static const textStyle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  Widget _buildDropdowns() => Row(
        children: [
          Flexible(
            child: Obx(() => CustomDropDown(
                  title: 'category'.tr,
                  value: _selectedCategory.value,
                  items: categories.keys.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category, style: textStyle),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _selectedCategory.value = value;
                      _selectedSubCategory.value = categories[value]!.first;
                    }
                  },
                )),
          ),
          const SizedBox(width: kDefaultPadding / 2),
          Flexible(
            child: Obx(() => CustomDropDown(
                  title: 'service'.tr,
                  value: _selectedSubCategory.value,
                  items: categories[_selectedCategory.value]!
                      .map((subcategory) => DropdownMenuItem(
                            value: subcategory,
                            child: Text(subcategory, style: textStyle),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      _selectedSubCategory.value = value;
                    }
                  },
                )),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        minimum: const EdgeInsets.all(kDefaultPadding / 2),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomBackButton(
                onPressed: () {
                  widget.controller.clearFilters();
                  Get.back();
                },
                icon: Icons.arrow_back,
                color: Theme.of(context).colorScheme.primary,
                backgroundColor: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(height: kDefaultPadding * 1.5),
              Text(
                widget.service == null
                    ? "${'create'.tr}\n${'new_service'.tr}"
                    : 'edit_service_action'.tr,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: kDefaultPadding),
              _buildDropdowns(),
              const SizedBox(height: kDefaultPadding),
              _buildTextField('Price', 'price'.tr, _priceController,
                  Validators.validatePrice),
              _buildTextField('Image URL', 'image_url'.tr, _imageUrlController,
                  Validators.validateImageUrl),
              _buildTextField('Duration', 'duration_minutes'.tr,
                  _durationController, Validators.validateDuration),
              _buildTextField('Rating', 'rating_0_5'.tr, _ratingController,
                  Validators.validateRating),
              const SizedBox(height: kDefaultPadding),
              Obx(() => CustomSwitchTile(
                  title: 'availability'.tr,
                  value: _availability.value,
                  onChanged: (value) {
                    _availability.value = value;
                    _formKey.currentState!.validate();
                  })),
              const SizedBox(height: kDefaultPadding * 3),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: buttonStyle(context: context),
                  child: Text('submit'.tr),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String key, String label,
      TextEditingController controller, String? Function(String?)? validator) {
    return Padding(
      padding: const EdgeInsets.only(bottom: kDefaultPadding),
      child: TextFormField(
        controller: controller,
        decoration: customInputDecoration(labelText: label, context: context),
        validator: validator,
        keyboardType: key.contains('Price') ||
                key.contains('Duration') ||
                key.contains('Rating')
            ? TextInputType.number
            : TextInputType.text,
      ),
    );
  }
}
