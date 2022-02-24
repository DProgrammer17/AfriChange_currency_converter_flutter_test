///This model holds the data gotten from the Fixer.io API response
class ConversionRateModel {
  ConversionRateModel({
    this.success,
    this.historical,
    this.date,
    this.timestamp,
    this.base,
    this.rates,
  });

  bool? success;
  bool? historical;
  DateTime? date;
  int? timestamp;
  String? base;
  Map<String, dynamic>? rates;

  static ConversionRateModel fromMap({required Map<String, dynamic> conversion}){
    return ConversionRateModel(
      success: conversion["success"],
      historical: conversion["historical"],
      date: DateTime.parse(conversion["date"]),
      timestamp: conversion["timestamp"],
      base: conversion["base"],
      rates: conversion["rates"],
    );
  }
}
