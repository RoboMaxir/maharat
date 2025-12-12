/// موتور تشخیص کلاهبرداری
/// این موتور الگوهای مشکوک را در پروژه‌ها و کارفرمایان بدون نیاز به داده‌های ابری شناسایی می‌کند
class FraudDetectionEngine {
  // الگوهای مشکوک که معمولاً در کلاهبرداری‌های فریلنسری ایران دیده می‌شوند
  static const List<String> _suspiciousKeywords = [
    'فوری', 'urgent', 'immediate', 'سرویس', 'پرداخت بعد از کار', 
    'کار تست', 'پروژه رایگان', 'نمونه کار رایگان', 'آزمایشی',
    'without upfront payment', 'free trial', 'sample work free'
  ];
  
  static const List<String> _suspiciousPaymentTerms = [
    'پس‌پرداخت', 'after delivery', 'post-payment', 'cash on delivery'
  ];
  
  static const List<String> _suspiciousProjectTypes = [
    'ساخت بات تلگرام', 'ساخت ربات تلگرام', 'seo magic', 
    'instagram follower', 'لایک خودکار', 'ربات تلگرام'
  ];

  /// بررسی احتمال کلاهبرداری بر اساس توضیحات پروژه
  /// 
  /// [projectDescription]: توضیحات کامل پروژه
  /// [paymentTerms]: شرایط پرداخت
  /// [clientHistory]: سابقه کارفرما (null اگر ناشناس باشد)
  /// [contactMethod]: روش ارتباطی کارفرما
  Map<String, dynamic> detectFraudRisk({
    required String projectDescription,
    required String paymentTerms,
    String? clientHistory,
    String? contactMethod,
  }) {
    double riskScore = 0.0;
    List<String> detectedIssues = [];
    
    // بررسی کلمات کلیدی مشکوک در توضیحات پروژه
    for (String keyword in _suspiciousKeywords) {
      if (projectDescription.toLowerCase().contains(keyword.toLowerCase())) {
        riskScore += 15.0;
        detectedIssues.add('کلمه مشکوک یافت شد: "$keyword"');
      }
    }
    
    // بررسی شرایط پرداخت مشکوک
    for (String term in _suspiciousPaymentTerms) {
      if (paymentTerms.toLowerCase().contains(term.toLowerCase())) {
        riskScore += 25.0;
        detectedIssues.add('شرایط پرداخت مشکوک: "$term"');
      }
    }
    
    // بررسی انواع پروژه‌های مشکوک
    for (String projectType in _suspiciousProjectTypes) {
      if (projectDescription.toLowerCase().contains(projectType.toLowerCase())) {
        riskScore += 20.0;
        detectedIssues.add('نوع پروژه مشکوک: "$projectType"');
      }
    }
    
    // بررسی سابقه کارفرما
    if (clientHistory == null || clientHistory.isEmpty) {
      riskScore += 10.0;
      detectedIssues.add('سابقه کارفرما مشخص نیست');
    } else if (clientHistory == 'new') {
      riskScore += 15.0;
      detectedIssues.add('کارفرمای جدید');
    }
    
    // بررسی روش ارتباطی
    if (contactMethod != null && 
        ['telegram', 'whatsapp', 'personal'].contains(contactMethod.toLowerCase())) {
      riskScore += 5.0;
      detectedIssues.add('روش ارتباطی غیررسمی: $contactMethod');
    }
    
    // اضافه کردن عوامل دیگر
    if (projectDescription.length < 50) {
      // توضیحات خیلی کوتاه
      riskScore += 10.0;
      detectedIssues.add('توضیحات پروژه بسیار کوتاه است');
    }
    
    if (projectDescription.contains(RegExp(r'[A-Z]{10,}'))) {
      // متن با حروف بزرگ زیاد (معمولاً تبلیغاتی یا فریب‌آمیز)
      riskScore += 15.0;
      detectedIssues.add('متن شامل حروف بزرگ بیش از حد است');
    }
    
    // دسته‌بندی ریسک
    String riskLevel = _classifyRiskLevel(riskScore);
    
    return {
      'riskScore': riskScore,
      'riskLevel': riskLevel,
      'detectedIssues': detectedIssues,
      'recommendation': _getRecommendation(riskLevel, detectedIssues),
      'safetyTips': _getSafetyTips(detectedIssues),
    };
  }
  
  /// دسته‌بندی سطح ریسک
  String _classifyRiskLevel(double score) {
    if (score >= 70) return 'بسیار بالا';
    if (score >= 50) return 'بالا';
    if (score >= 30) return 'متوسط';
    if (score >= 15) return 'کم';
    return 'خیلی کم';
  }
  
  /// توصیه‌های ایمنی بر اساس سطح ریسک
  String _getRecommendation(String riskLevel, List<String> issues) {
    switch (riskLevel) {
      case 'بسیار بالا':
        return 'به شدت توصیه می‌شود این پروژه را رد کنید. احتمال کلاهبرداری بسیار زیاد است.';
      case 'بالا':
        return 'پروژه را با احتیاط زیاد پیش ببرید یا بهتر است رد کنید.';
      case 'متوسط':
        return 'پروژه را با توافق‌نامه رسمی و پیش‌پرداخت اندک پیش ببرید.';
      case 'کم':
        return 'پروژه نسبتاً ایمن به نظر می‌رسد، اما همچنان از توافق‌نامه استفاده کنید.';
      default:
        return 'پروژه ایمن است، اما همیشه از توافق‌نامه استفاده کنید.';
    }
  }
  
  /// نکات ایمنی بر اساس مسائل شناسایی‌شده
  List<String> _getSafetyTips(List<String> issues) {
    List<String> tips = [];
    
    if (issues.any((issue) => issue.contains('پس‌پرداخت'))) {
      tips.add('هرگز بدون پیش‌پرداخت کار نکنید - این یکی از مهم‌ترین قوانین فریلنسری است');
    }
    
    if (issues.any((issue) => issue.contains('کارفرمای جدید'))) {
      tips.add('کارفرمای جدید است، با پیش‌پرداخت کم شروع کنید و اعتماد را مرحله‌ای ایجاد کنید');
    }
    
    if (issues.any((issue) => issue.contains('توضیحات پروژه بسیار کوتاه است'))) {
      tips.add('درخواست برای جزئیات بیشتر کنید - توضیحات کافی برای شروع کار وجود ندارد');
    }
    
    if (tips.isEmpty) {
      tips.add('همیشه یک توافق‌نامه کار رسمی داشته باشید');
      tips.add('پیش‌پرداخت منطقی دریافت کنید');
      tips.add('نمونه کار رایگان ندهید');
    }
    
    return tips;
  }
}

// نمونه استفاده از موتور تشخیص کلاهبرداری
class FraudDetectionExample {
  static void demonstrateFraudDetectionEngine() {
    final engine = FraudDetectionEngine();
    
    print('\n=== نمونه کاربرد موتور تشخیص کلاهبرداری ===');
    
    // نمونه یک پروژه مشکوک
    var fraudResult = engine.detectFraudRisk(
      projectDescription: 'پروژه فوری ساخت ربات تلگرام - کار تست لازم است - نیازی به پیش‌پرداخت نیست - پرداخت بعد از تحویل',
      paymentTerms: 'پس‌پرداخت کامل',
      clientHistory: 'new',
      contactMethod: 'telegram',
    );
    
    print('امتیاز ریسک: ${fraudResult['riskScore']}%');
    print('سطح ریسک: ${fraudResult['riskLevel']}');
    print('مسائل شناسایی‌شده:');
    for (var issue in fraudResult['detectedIssues']) {
      print('  - $issue');
    }
    print('توصیه: ${fraudResult['recommendation']}');
    print('نکات ایمنی:');
    for (var tip in fraudResult['safetyTips']) {
      print('  - $tip');
    }
  }
}