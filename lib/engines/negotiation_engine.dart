import 'dart:math';

/// موتور هوش مصنوعی مذاکره هوشمند
/// این موتور قیمت پیشنهادی را بر اساس بازار ایران، تجربه کاربر و نوع پروژه محاسبه می‌کند
class NegotiationEngine {
  // پایگاه دانش محلی برای قیمت‌های بازار ایران
  static const Map<String, double> _iranianMarketRates = {
    'web_development': 800000.0, // تومان در روز
    'mobile_app': 1000000.0,
    'graphic_design': 400000.0,
    'content_writing': 200000.0,
    'digital_marketing': 600000.0,
    'data_entry': 90000.0,
    'translation': 150000.0,
    'video_editing': 300000.0,
  };

  /// محاسبه قیمت پیشنهادی هوشمند
  /// 
  /// [projectType]: نوع پروژه (مثلاً 'web_development')
  /// [experienceLevel]: سطح تجربه کاربر (1-5)
  /// [projectComplexity]: پیچیدگی پروژه (1-5)
  /// [deadlineDays]: تعداد روزهای مهلت پروژه
  /// [clientType]: نوع کارفرما ('local', 'international', 'startup')
  double calculateSmartPrice({
    required String projectType,
    required int experienceLevel,
    required int projectComplexity,
    required int deadlineDays,
    String clientType = 'local',
  }) {
    // بررسی اینکه نوع پروژه در پایگاه دانش وجود دارد
    if (!_iranianMarketRates.containsKey(projectType)) {
      throw ArgumentError('نوع پروژه ناشناخته: $projectType');
    }

    // قیمت پایه بازار ایران برای نوع پروژه
    double basePrice = _iranianMarketRates[projectType]!;
    
    // ضریب تجربه (1 = مبتدی، 5 = متخصص)
    double experienceMultiplier = 0.5 + (experienceLevel * 0.15); // 0.65 تا 1.25
    
    // ضریب پیچیدگی (1 = ساده، 5 = بسیار پیچیده)
    double complexityMultiplier = 0.7 + (projectComplexity * 0.15); // 0.85 تا 1.45
    
    // ضریب مهلت (هرچه مهلت کمتر باشد، قیمت بالاتر)
    double deadlineMultiplier = deadlineDays <= 3 ? 2.0 : 
                               deadlineDays <= 7 ? 1.5 : 
                               deadlineDays <= 15 ? 1.2 : 1.0;
    
    // ضریب نوع کارفرما
    double clientMultiplier = clientType == 'international' ? 1.5 :
                             clientType == 'startup' ? 0.8 : 1.0;

    // محاسبه قیمت نهایی
    double finalPrice = basePrice * 
                       experienceMultiplier * 
                       complexityMultiplier * 
                       deadlineMultiplier * 
                       clientMultiplier;

    // گرد کردن قیمت به نزدیک‌ترین 1000 تومان
    return (finalPrice / 1000).round() * 1000.toDouble();
  }

  /// ارائه پیشنهاد مذاکره‌ای برای کاربر
  /// 
  /// [currentOffer]: پیشنهاد فعلی کارفرما
  /// [calculatedPrice]: قیمت محاسبه‌شده توسط سیستم
  /// [negotiationRound]: دور مذاکره (1-3)
  Map<String, dynamic> suggestNegotiationResponse({
    required double currentOffer,
    required double calculatedPrice,
    int negotiationRound = 1,
  }) {
    double difference = calculatedPrice - currentOffer;
    double percentageDiff = (difference / calculatedPrice) * 100;
    
    String suggestion = '';
    String justification = '';
    
    if (percentageDiff > 20) {
      // پیشنهاد کمتر از ۲۰٪ از قیمت منصفانه
      suggestion = 'پیشنهاد قیمت شما بسیار پایین‌تر از نرخ بازار است';
      justification = 'بر اساس تجربه من و نرخ‌های بازار ایران، این پروژه حداقل باید ${calculatedPrice.toStringAsFixed(0)} تومان باشد.';
    } else if (percentageDiff > 5) {
      // پیشنهاد ۵ تا ۲۰٪ کمتر
      suggestion = 'می‌توانیم قیمت را به ${((currentOffer + calculatedPrice) / 2).toStringAsFixed(0)} تومان رسانیم';
      justification = 'این قیمت میانگین بین پیشنهاد شما و نرخ منصفانه بازار است.';
    } else if (percentageDiff < -10) {
      // پیشنهاد بیشتر از ۱۰٪ از قیمت منصفانه
      suggestion = 'پیشنهاد خوبی است، می‌توانیم بپذیریم';
      justification = 'قیمت ارائه‌شده حتی کمی بالاتر از نرخ استاندارد بازار است.';
    } else {
      // قیمت مناسب
      suggestion = 'پیشنهاد شما قابل قبول است';
      justification = 'قیمت در بازه منصفانه بازار ایران قرار دارد.';
    }
    
    return {
      'suggestion': suggestion,
      'justification': justification,
      'recommendedPrice': max(currentOffer, calculatedPrice),
      'negotiationStrategy': _getNegotiationStrategy(negotiationRound, percentageDiff),
    };
  }
  
  /// تعیین استراتژی مذاکره بر اساس دور و اختلاف قیمت
  String _getNegotiationStrategy(int round, double percentageDiff) {
    if (round == 1) {
      return percentageDiff > 20 ? 'پذیرش مطلق ندهید، حداقل ۱۵٪ افزایش بخواهید' :
             percentageDiff > 5 ? 'پیشنهاد متقابل منصفانه بدهید' :
             'پذیرش نسبی با توضیحات';
    } else if (round == 2) {
      return percentageDiff > 15 ? 'مذاکره مستقیم برای افزایش قیمت' :
             percentageDiff > 0 ? 'پیشنهاد نهایی منصفانه' :
             'پذیرش با شرایط اضافی';
    } else {
      return percentageDiff > 10 ? 'پایبندی به قیمت منصفانه' :
             'تصمیم نهایی با توجه به سایر شرایط پروژه';
    }
  }
}

// نمونه استفاده از موتور مذاکره
class NegotiationExample {
  static void demonstrateNegotiationEngine() {
    final engine = NegotiationEngine();
    
    print('=== نمونه کاربرد موتور مذاکره هوشمند ===');
    
    // نمونه از بازار کار فریلنس ایران
    var smartPrice = engine.calculateSmartPrice(
      projectType: 'web_development',
      experienceLevel: 4,
      projectComplexity: 3,
      deadlineDays: 10,
      clientType: 'local',
    );
    
    print('قیمت پیشنهادی هوشمند: ${smartPrice.toStringAsFixed(0)} تومان');
    
    // پاسخ به یک پیشنهاد کارفرما
    var negotiationResponse = engine.suggestNegotiationResponse(
      currentOffer: 1500000.0,
      calculatedPrice: smartPrice,
      negotiationRound: 1,
    );
    
    print('پیشنهاد مذاکره: ${negotiationResponse['suggestion']}');
    print('توضیح: ${negotiationResponse['justification']}');
    print('استراتژی: ${negotiationResponse['negotiationStrategy']}');
  }
}