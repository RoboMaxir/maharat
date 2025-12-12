/// موتور یادگیری تطبیقی
/// این موتور چالش‌های آموزشی را بر اساس رفتار کاربر تولید می‌کند
class AdaptiveLearningEngine {
  // پایگاه دانش محلی برای چالش‌های آموزشی فریلنسری ایران
  static const Map<String, List<Map<String, String>>> _learningChallenges = {
    'web_development': [
      {
        'title': 'مدیریت زمان در پروژه‌های وب',
        'challenge': 'شما یک پروژه وب با مهلت ۲ هفته دارید، برنامه‌ریزی مناسب چگونه است؟',
        'difficulty': 'easy',
        'solution': 'تقسیم پروژه به بخش‌های کوچکتر، تعیین مهلت برای هر بخش، تست مرحله‌ای'
      },
      {
        'title': 'مذاکره قیمت پروژه وب',
        'challenge': 'کارفرمایی پیشنهاد ۳۰۰ هزارتومان برای سایت شخصی می‌دهد، چطور پاسخ دهید؟',
        'difficulty': 'medium',
        'solution': 'ارائه فهرست خدمات، توضیح ارزش افزوده، پیشنهاد قیمت منصفانه'
      },
      {
        'title': 'مدیریت کارفرمای دشوار',
        'challenge': 'کارفرما مدام تغییرات درخواست می‌کند، چطور عمل می‌کنید؟',
        'difficulty': 'hard',
        'solution': 'تعیین محدوده کار، توافق‌نامه جدید برای تغییرات، توضیح هزینه اضافی'
      },
    ],
    'mobile_app': [
      {
        'title': 'طراحی UI/UX مناسب',
        'challenge': 'چطور طرحی طراحی کنیم که برای کاربران ایرانی قابل فهم باشد؟',
        'difficulty': 'medium',
        'solution': 'استفاده از راست به چپ مناسب، رعایت فرهنگ بومی، تست با کاربران واقعی'
      },
      {
        'title': 'بهینه‌سازی عملکرد اپلیکیشن',
        'challenge': 'اپلیکیشن شما در اینترنت ضعیف ایران کند است، راه‌حل؟',
        'difficulty': 'hard',
        'solution': 'کاهش حجم داده، کش کردن اطلاعات، بهینه‌سازی تصاویر'
      },
    ],
    'graphic_design': [
      {
        'title': 'استفاده از فونت‌های فارسی',
        'challenge': 'چه فونت‌هایی برای پروژه‌های فارسی مناسب‌ترند؟',
        'difficulty': 'easy',
        'solution': 'فونت‌های وزن مناسب، خوانایی بالا، سازگاری با راست به چپ'
      },
      {
        'title': 'طراحی هویت بصری',
        'challenge': 'چطور هویت بصری منحصربه‌فرد برای یک کسب‌وکار ایرانی ایجاد کنیم؟',
        'difficulty': 'medium',
        'solution': 'بررسی رقبا، تحلیل مخاطب، استفاده از نمادهای فرهنگی'
      },
    ],
    'content_writing': [
      {
        'title': 'نوشتن محتوای SEO',
        'challenge': 'چطور محتوایی بنویسیم که در گوگل فارسی رتبه بالایی داشته باشد؟',
        'difficulty': 'medium',
        'solution': 'استفاده از کلمات کلیدی مناسب، ساختار صحیح، طول مناسب متن'
      },
      {
        'title': 'نوشتن تبلیغات جذاب',
        'challenge': 'چگونه جمله تبلیغی موثر برای محصول ایرانی بنویسیم؟',
        'difficulty': 'hard',
        'solution': 'درک نیاز مشتری، ایجاد احساس فومو، دعوت به اقدام'
      },
    ]
  };

  /// تولید چالش آموزشی مناسب بر اساس سطح کاربر و تخصص
  /// 
  /// [skillArea]: حوزه تخصصی کاربر (مثلاً 'web_development')
  /// [userLevel]: سطح کاربر (1-5)
  /// [lastChallenge]: آخرین چالش حل‌شده توسط کاربر
  /// [performance]: عملکرد قبلی کاربر (0-1)
  Map<String, dynamic>? generateAdaptiveChallenge({
    required String skillArea,
    required int userLevel,
    String? lastChallenge,
    double performance = 0.5,
  }) {
    // بررسی اینکه حوزه تخصصی در پایگاه دانش وجود دارد
    if (!_learningChallenges.containsKey(skillArea)) {
      return null;
    }

    // تعیین سطح دشواری مناسب بر اساس سطح کاربر و عملکرد
    String targetDifficulty = _determineDifficulty(userLevel, performance);
    
    // پیدا کردن چالش مناسب
    List<Map<String, String>> challenges = _learningChallenges[skillArea]!;
    
    // فیلتر چالش‌ها بر اساس سطح دشواری و عدم تکرار
    List<Map<String, String>> filteredChallenges = challenges
        .where((challenge) => 
            challenge['difficulty'] == targetDifficulty && 
            challenge['title'] != lastChallenge)
        .toList();
    
    // اگر چالشی با سطح دشواری هدف نبود، از سطوح دیگر انتخاب کن
    if (filteredChallenges.isEmpty) {
      filteredChallenges = challenges.where((challenge) => 
          challenge['title'] != lastChallenge).toList();
    }
    
    // اگر هنوز چالشی نبود، انتخاب تصادفی
    if (filteredChallenges.isEmpty) {
      return null;
    }
    
    // انتخاب تصادفی یک چالش
    int randomIndex = DateTime.now().millisecondsSinceEpoch % filteredChallenges.length;
    Map<String, String> selectedChallenge = filteredChallenges[randomIndex];
    
    return {
      'title': selectedChallenge['title'],
      'challenge': selectedChallenge['challenge'],
      'difficulty': selectedChallenge['difficulty'],
      'solution': selectedChallenge['solution'],
      'skillArea': skillArea,
      'estimatedTime': _estimateTime(selectedChallenge['difficulty']!),
      'learningObjective': _getLearningObjective(skillArea, selectedChallenge['title']!),
    };
  }
  
  /// تعیین سطح دشواری بر اساس سطح کاربر و عملکرد
  String _determineDifficulty(int userLevel, double performance) {
    // فرمول ساده برای تعیین سطح دشواری مناسب
    double adjustedLevel = userLevel + (performance - 0.5) * 2; // تأثیر عملکرد در سطح دشواری
    
    if (adjustedLevel >= 4.0) return 'hard';
    if (adjustedLevel >= 2.5) return 'medium';
    return 'easy';
  }
  
  /// تخمین زمان لازم برای چالش
  int _estimateTime(String difficulty) {
    switch (difficulty) {
      case 'easy': return 15; // دقیقه
      case 'medium': return 30;
      case 'hard': return 60;
      default: return 20;
    }
  }
  
  /// تعیین هدف یادگیری برای چالش
  String _getLearningObjective(String skillArea, String challengeTitle) {
    if (skillArea == 'web_development') {
      if (challengeTitle.contains('مذاکره')) {
        return 'تقویت مهارت مذاکره و قیمت‌گذاری';
      } else if (challengeTitle.contains('مدیریت')) {
        return 'بهبود مهارت مدیریت پروژه';
      }
    } else if (skillArea == 'graphic_design') {
      if (challengeTitle.contains('هویت')) {
        return 'تقویت طراحی هویت بصری';
      }
    } else if (skillArea == 'content_writing') {
      if (challengeTitle.contains('SEO')) {
        return 'بهبود نوشتار برای موتورهای جستجو';
      }
    }
    
    return 'تقویت مهارت‌های تخصصی در $skillArea';
  }
  
  /// به‌روزرسانی پروفایل یادگیری کاربر
  /// 
  /// [userId]: شناسه کاربر
  /// [challengeSolved]: چالش حل‌شده
  /// [timeSpent]: زمان صرف‌شده (دقیقه)
  /// [satisfaction]: رضایت کاربر از چالش (1-5)
  Map<String, dynamic> updateLearningProfile({
    required String userId,
    required String challengeSolved,
    required int timeSpent,
    required int satisfaction,
  }) {
    // محاسبه نمره یادگیری (ساده‌شده)
    double learningScore = (satisfaction / 5.0) * (timeSpent > 0 ? 1.0 : 0.5);
    
    return {
      'userId': userId,
      'challengeCompleted': challengeSolved,
      'learningScore': learningScore,
      'nextRecommendedChallenge': _suggestNextChallenge(userId, learningScore),
      'skillImprovement': _calculateSkillImprovement(learningScore),
      'motivationalMessage': _generateMotivation(satisfaction),
    };
  }
  
  /// پیشنهاد چالش بعدی بر اساس پیشرفت کاربر
  String _suggestNextChallenge(String userId, double learningScore) {
    if (learningScore > 0.8) {
      return 'چالش سطح بالاتری را امتحان کنید';
    } else if (learningScore > 0.5) {
      return 'چالش مشابهی را دوباره تمرین کنید';
    } else {
      return 'چالش ساده‌تری را امتحان کنید';
    }
  }
  
  /// محاسبه بهبود مهارت
  String _calculateSkillImprovement(double score) {
    if (score >= 0.9) return 'بسیار عالی! مهارت شما بهبود چشمگیری یافت';
    if (score >= 0.7) return 'خوب! مهارت شما بهبود یافت';
    if (score >= 0.5) return 'متوسط - همچنان می‌توانید بهتر شوید';
    return 'نیاز به تمرین بیشتر دارید';
  }
  
  /// تولید پیام انگیزشی
  String _generateMotivation(int satisfaction) {
    switch (satisfaction) {
      case 5: return 'عالی! اینطور ادامه دهید!';
      case 4: return 'خوب! پیشرفت شما قابل تحسین است';
      case 3: return 'خوب است، می‌توانید بهتر شوید';
      case 2: return 'کمی تلاش بیشتر نیاز است';
      case 1: return 'نگران نباشید، تمرین باعث مهارت می‌شود';
      default: return 'ادامه دهید، موفقیت نیاز به تلاش دارد';
    }
  }
}

// نمونه استفاده از موتور یادگیری تطبیقی
class AdaptiveLearningExample {
  static void demonstrateAdaptiveLearningEngine() {
    final engine = AdaptiveLearningEngine();
    
    print('\n=== نمونه کاربرد موتور یادگیری تطبیقی ===');
    
    // تولید چالش برای یک فریلنسر وب
    var challenge = engine.generateAdaptiveChallenge(
      skillArea: 'web_development',
      userLevel: 3,
      performance: 0.7,
    );
    
    if (challenge != null) {
      print('عنوان چالش: ${challenge['title']}');
      print('شرح چالش: ${challenge['challenge']}');
      print('دشواری: ${challenge['difficulty']}');
      print('زمان تخمینی: ${challenge['estimatedTime']} دقیقه');
      print('هدف یادگیری: ${challenge['learningObjective']}');
      
      // شبیه‌سازی حل چالش توسط کاربر
      var profileUpdate = engine.updateLearningProfile(
        userId: 'user123',
        challengeSolved: challenge['title'].toString(),
        timeSpent: 25,
        satisfaction: 4,
      );
      
      print('\nبه‌روزرسانی پروفایل یادگیری:');
      print('نمره یادگیری: ${profileUpdate['learningScore']}');
      print('پیشنهاد چالش بعدی: ${profileUpdate['nextRecommendedChallenge']}');
      print('بهبود مهارت: ${profileUpdate['skillImprovement']}');
      print('پیام انگیزشی: ${profileUpdate['motivationalMessage']}');
    }
  }
}