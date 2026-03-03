class CheckOutSessionModel {
  CheckOutSessionData? data;

  CheckOutSessionModel({this.data});

  CheckOutSessionModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? CheckOutSessionData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class CheckOutSessionData {
  String? id;
  String? object;
  String? afterExpiration;
  bool? allowPromotionCodes;
  int? amountSubtotal;
  int? amountTotal;
  AutomaticTax? automaticTax;
  String? billingAddressCollection;
  String? cancelUrl;
  String? clientReferenceId;
  String? clientSecret;
  String? consent;
  String? consentCollection;
  int? created;
  String? currency;
  String? currencyConversion;
  List<String>? customFields;
  CustomText? customText;
  String? customer;
  String? customerCreation;
  CustomerDetails? customerDetails;
  String? customerEmail;
  int? expiresAt;
  String? invoice;
  InvoiceCreation? invoiceCreation;
  bool? livemode;
  String? locale;
  List<String>? metadata;
  String? mode;
  String? paymentIntent;
  String? paymentLink;
  String? paymentMethodCollection;
  String? paymentMethodConfigurationDetails;
  PaymentMethodOptions? paymentMethodOptions;
  List<String>? paymentMethodTypes;
  String? paymentStatus;
  PhoneNumberCollection? phoneNumberCollection;
  String? recoveredFrom;
  String? savedPaymentMethodOptions;
  String? setupIntent;
  String? shippingAddressCollection;
  String? shippingCost;
  String? shippingDetails;
  List<String>? shippingOptions;
  String? status;
  String? submitType;
  String? subscription;
  String? successUrl;
  TotalDetails? totalDetails;
  String? uiMode;
  String? url;

  CheckOutSessionData(
      {this.id,
      this.object,
      this.afterExpiration,
      this.allowPromotionCodes,
      this.amountSubtotal,
      this.amountTotal,
      this.automaticTax,
      this.billingAddressCollection,
      this.cancelUrl,
      this.clientReferenceId,
      this.clientSecret,
      this.consent,
      this.consentCollection,
      this.created,
      this.currency,
      this.currencyConversion,
      this.customFields,
      this.customText,
      this.customer,
      this.customerCreation,
      this.customerDetails,
      this.customerEmail,
      this.expiresAt,
      this.invoice,
      this.invoiceCreation,
      this.livemode,
      this.locale,
      this.metadata,
      this.mode,
      this.paymentIntent,
      this.paymentLink,
      this.paymentMethodCollection,
      this.paymentMethodConfigurationDetails,
      this.paymentMethodOptions,
      this.paymentMethodTypes,
      this.paymentStatus,
      this.phoneNumberCollection,
      this.recoveredFrom,
      this.savedPaymentMethodOptions,
      this.setupIntent,
      this.shippingAddressCollection,
      this.shippingCost,
      this.shippingDetails,
      this.shippingOptions,
      this.status,
      this.submitType,
      this.subscription,
      this.successUrl,
      this.totalDetails,
      this.uiMode,
      this.url});

  CheckOutSessionData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    object = json['object'];
    afterExpiration = json['after_expiration'];
    allowPromotionCodes = json['allow_promotion_codes'];
    amountSubtotal = json['amount_subtotal'];
    amountTotal = json['amount_total'];
    automaticTax = json['automatic_tax'] != null
        ? AutomaticTax.fromJson(json['automatic_tax'])
        : null;
    billingAddressCollection = json['billing_address_collection'];
    cancelUrl = json['cancel_url'];
    clientReferenceId = json['client_reference_id'];
    clientSecret = json['client_secret'];
    consent = json['consent'];
    consentCollection = json['consent_collection'];
    created = json['created'];
    currency = json['currency'];
    currencyConversion = json['currency_conversion'];
    if (json['custom_fields'] != null) {
      customFields = [];
      json['custom_fields'].forEach((v) {});
    }
    customText = json['custom_text'] != null
        ? CustomText.fromJson(json['custom_text'])
        : null;
    customer = json['customer'];
    customerCreation = json['customer_creation'];
    customerDetails = json['customer_details'] != null
        ? CustomerDetails.fromJson(json['customer_details'])
        : null;
    customerEmail = json['customer_email'];
    expiresAt = json['expires_at'];
    invoice = json['invoice'];
    invoiceCreation = json['invoice_creation'] != null
        ? InvoiceCreation.fromJson(json['invoice_creation'])
        : null;
    livemode = json['livemode'];
    locale = json['locale'];
    if (json['metadata'] != null) {
      metadata = [];
      json['metadata'].forEach((v) {});
    }
    mode = json['mode'];
    paymentIntent = json['payment_intent'];
    paymentLink = json['payment_link'];
    paymentMethodCollection = json['payment_method_collection'];
    paymentMethodConfigurationDetails =
        json['payment_method_configuration_details'];
    paymentMethodOptions = json['payment_method_options'] != null
        ? PaymentMethodOptions.fromJson(json['payment_method_options'])
        : null;
    paymentMethodTypes = json['payment_method_types'].cast<String>();
    paymentStatus = json['payment_status'];
    phoneNumberCollection = json['phone_number_collection'] != null
        ? PhoneNumberCollection.fromJson(json['phone_number_collection'])
        : null;
    recoveredFrom = json['recovered_from'];
    savedPaymentMethodOptions = json['saved_payment_method_options'];
    setupIntent = json['setup_intent'];
    shippingAddressCollection = json['shipping_address_collection'];
    shippingCost = json['shipping_cost'];
    shippingDetails = json['shipping_details'];
    if (json['shipping_options'] != null) {
      shippingOptions = [];
      json['shipping_options'].forEach((v) {});
    }
    status = json['status'];
    submitType = json['submit_type'];
    subscription = json['subscription'];
    successUrl = json['success_url'];
    totalDetails = json['total_details'] != null
        ? TotalDetails.fromJson(json['total_details'])
        : null;
    uiMode = json['ui_mode'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['after_expiration'] = afterExpiration;
    data['allow_promotion_codes'] = allowPromotionCodes;
    data['amount_subtotal'] = amountSubtotal;
    data['amount_total'] = amountTotal;
    if (automaticTax != null) {
      data['automatic_tax'] = automaticTax!.toJson();
    }
    data['billing_address_collection'] = billingAddressCollection;
    data['cancel_url'] = cancelUrl;
    data['client_reference_id'] = clientReferenceId;
    data['client_secret'] = clientSecret;
    data['consent'] = consent;
    data['consent_collection'] = consentCollection;
    data['created'] = created;
    data['currency'] = currency;
    data['currency_conversion'] = currencyConversion;
    if (customFields != null) {
      data['custom_fields'] = [];
    }
    if (customText != null) {
      data['custom_text'] = customText!.toJson();
    }
    data['customer'] = customer;
    data['customer_creation'] = customerCreation;
    if (customerDetails != null) {
      data['customer_details'] = customerDetails!.toJson();
    }
    data['customer_email'] = customerEmail;
    data['expires_at'] = expiresAt;
    data['invoice'] = invoice;
    if (invoiceCreation != null) {
      data['invoice_creation'] = invoiceCreation!.toJson();
    }
    data['livemode'] = livemode;
    data['locale'] = locale;
    if (metadata != null) {
      data['metadata'] = [];
    }
    data['mode'] = mode;
    data['payment_intent'] = paymentIntent;
    data['payment_link'] = paymentLink;
    data['payment_method_collection'] = paymentMethodCollection;
    data['payment_method_configuration_details'] =
        paymentMethodConfigurationDetails;
    if (paymentMethodOptions != null) {
      data['payment_method_options'] = paymentMethodOptions!.toJson();
    }
    data['payment_method_types'] = paymentMethodTypes;
    data['payment_status'] = paymentStatus;
    if (phoneNumberCollection != null) {
      data['phone_number_collection'] = phoneNumberCollection!.toJson();
    }
    data['recovered_from'] = recoveredFrom;
    data['saved_payment_method_options'] = savedPaymentMethodOptions;
    data['setup_intent'] = setupIntent;
    data['shipping_address_collection'] = shippingAddressCollection;
    data['shipping_cost'] = shippingCost;
    data['shipping_details'] = shippingDetails;
    if (shippingOptions != null) {
      data['shipping_options'] = [];
    }
    data['status'] = status;
    data['submit_type'] = submitType;
    data['subscription'] = subscription;
    data['success_url'] = successUrl;
    if (totalDetails != null) {
      data['total_details'] = totalDetails!.toJson();
    }
    data['ui_mode'] = uiMode;
    data['url'] = url;
    return data;
  }
}

class AutomaticTax {
  bool? enabled;
  String? liability;
  String? status;

  AutomaticTax({this.enabled, this.liability, this.status});

  AutomaticTax.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    liability = json['liability'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    data['liability'] = liability;
    data['status'] = status;
    return data;
  }
}

class CustomText {
  String? afterSubmit;
  String? shippingAddress;
  String? submit;
  String? termsOfServiceAcceptance;

  CustomText(
      {this.afterSubmit,
      this.shippingAddress,
      this.submit,
      this.termsOfServiceAcceptance});

  CustomText.fromJson(Map<String, dynamic> json) {
    afterSubmit = json['after_submit'];
    shippingAddress = json['shipping_address'];
    submit = json['submit'];
    termsOfServiceAcceptance = json['terms_of_service_acceptance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['after_submit'] = afterSubmit;
    data['shipping_address'] = shippingAddress;
    data['submit'] = submit;
    data['terms_of_service_acceptance'] = termsOfServiceAcceptance;
    return data;
  }
}

class CustomerDetails {
  String? address;
  String? email;
  String? name;
  String? phone;
  String? taxExempt;
  String? taxIds;

  CustomerDetails(
      {this.address,
      this.email,
      this.name,
      this.phone,
      this.taxExempt,
      this.taxIds});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    taxExempt = json['tax_exempt'];
    taxIds = json['tax_ids'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['email'] = email;
    data['name'] = name;
    data['phone'] = phone;
    data['tax_exempt'] = taxExempt;
    data['tax_ids'] = taxIds;
    return data;
  }
}

class InvoiceCreation {
  bool? enabled;
  InvoiceData? invoiceData;

  InvoiceCreation({this.enabled, this.invoiceData});

  InvoiceCreation.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
    invoiceData = json['invoice_data'] != null
        ? InvoiceData.fromJson(json['invoice_data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    if (invoiceData != null) {
      data['invoice_data'] = invoiceData!.toJson();
    }
    return data;
  }
}

class InvoiceData {
  String? accountTaxIds;
  String? customFields;
  String? description;
  String? footer;
  String? issuer;
  List<Null>? metadata;
  String? renderingOptions;

  InvoiceData(
      {this.accountTaxIds,
      this.customFields,
      this.description,
      this.footer,
      this.issuer,
      this.metadata,
      this.renderingOptions});

  InvoiceData.fromJson(Map<String, dynamic> json) {
    accountTaxIds = json['account_tax_ids'];
    customFields = json['custom_fields'];
    description = json['description'];
    footer = json['footer'];
    issuer = json['issuer'];
    if (json['metadata'] != null) {
      metadata = <Null>[];
    }
    renderingOptions = json['rendering_options'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['account_tax_ids'] = accountTaxIds;
    data['custom_fields'] = customFields;
    data['description'] = description;
    data['footer'] = footer;
    data['issuer'] = issuer;
    if (metadata != null) {
      data['metadata'] = [];
    }
    data['rendering_options'] = renderingOptions;
    return data;
  }
}

class PaymentMethodOptions {
  Card? card;

  PaymentMethodOptions({this.card});

  PaymentMethodOptions.fromJson(Map<String, dynamic> json) {
    card = json['card'] != null ? Card.fromJson(json['card']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (card != null) {
      data['card'] = card!.toJson();
    }
    return data;
  }
}

class Card {
  String? requestThreeDSecure;

  Card({this.requestThreeDSecure});

  Card.fromJson(Map<String, dynamic> json) {
    requestThreeDSecure = json['request_three_d_secure'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_three_d_secure'] = requestThreeDSecure;
    return data;
  }
}

class PhoneNumberCollection {
  bool? enabled;

  PhoneNumberCollection({this.enabled});

  PhoneNumberCollection.fromJson(Map<String, dynamic> json) {
    enabled = json['enabled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['enabled'] = enabled;
    return data;
  }
}

class TotalDetails {
  int? amountDiscount;
  int? amountShipping;
  int? amountTax;

  TotalDetails({this.amountDiscount, this.amountShipping, this.amountTax});

  TotalDetails.fromJson(Map<String, dynamic> json) {
    amountDiscount = json['amount_discount'];
    amountShipping = json['amount_shipping'];
    amountTax = json['amount_tax'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['amount_discount'] = amountDiscount;
    data['amount_shipping'] = amountShipping;
    data['amount_tax'] = amountTax;
    return data;
  }
}
