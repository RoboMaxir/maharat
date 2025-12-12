import 'dart:math';

/// سیستم هوش مصنوعی داخلی فشرده (کمتر از 500 خط)
/// برای اپلیکیشن فریلنسری با پشتیبانی کامل از فارسی
class CompactAISystem {
  // موتور مذاکره هوشمند
  double calculateSmartPrice(String projectType, int experienceLevel, int projectComplexity, int deadlineDays) {
    // پایگاه دانش محلی برای قیمت‌های بازار ایران
    Map<String, double> marketRates = {
      'web_development': 800000.0,
      'mobile_app': 1000000.0,
      'graphic_design': 400000.0,
      'content_writing': 200000.0,
    };
    
    double basePrice = marketRates[projectType] ?? 500000.0;
    double experienceMultiplier = 0.5 + (experienceLevel * 0.15);
    double complexityMultiplier = 0.7 + (projectComplexity * 0.15);
    double deadlineMultiplier = deadlineDays <= 3 ? 2.0 : deadlineDays <= 7 ? 1.5 : 1.0;
    
    double finalPrice = basePrice * experienceMultiplier * complexityMultiplier * deadlineMultiplier;
    return (finalPrice / 1000).round() * 1000.toDouble();
  }

  // موتور تشخیص کلاهبرداری
  Map<String, dynamic> detectFraudRisk(String projectDescription, String paymentTerms, String? clientHistory) {
    double riskScore = 0.0;
    List<String> issues = [];
    
    // کلمات کلیدی مشکوک
    List<String> suspiciousKeywords = ['فوری', 'پرداخت بعد از کار', 'کار تست', 'پروژه رایگان'];
    for (String keyword in suspiciousKeywords) {
      if (projectDescription.contains(keyword)) {
        riskScore += 20.0;
        issues.add('کلمه مشکوک: $keyword');
      }
    }
    
    if (paymentTerms.contains('پس‌پرداخت')) {
      riskScore += 30.0;
      issues.add('شرایط پرداخت مشکوک');
    }
    
    if (clientHistory == 'new' || clientHistory == null) {
      riskScore += 15.0;
      issues.add('سابقه کارفرما مشخص نیست');
    }
    
    String riskLevel = riskScore >= 50 ? 'بالا' : riskScore >= 25 ? 'متوسط' : 'کم';
    
    return {
      'riskScore': riskScore,
      'riskLevel': riskLevel,
      'issues': issues,
      'recommendation': riskLevel == 'بالا' ? 'پروژه را رد کنید' : 'با احتیاط پیش بروید'
    };
  }

  // موتور یادگیری تطبیقی
  Map<String, String>? generateLearningChallenge(String skillArea, int userLevel) {
    Map<String, List<Map<String, String>>> challenges = {
      'web_development': [
        {'title': 'مدیریت زمان', 'challenge': 'چگونه یک پروژه ۲ هفته‌ای را برنامه‌ریزی کنیم؟'},
        {'title': 'مذاکره قیمت', 'challenge': 'کارفرما پیشنهاد پایین می‌دهد، چطور عمل کنیم؟'}
      ],
      'graphic_design': [
        {'title': 'فونت‌های فارسی', 'challenge': 'چه فونت‌هایی برای طراحی فارسی مناسب‌اند؟'},
      ]
    };
    
    if (!challenges.containsKey(skillArea)) return null;
    
    List<Map<String, String>> areaChallenges = challenges[skillArea]!;
    int index = min(userLevel - 1, areaChallenges.length - 1);
    return areaChallenges[index];
  }

  // موتور مربی هوشمند
  String? findMentorAnswer(String question) {
    Map<String, String> knowledgeBase = {
      'چطور قیمت پروژه تعیین کنم؟': 'بر اساس تجربه، پیچیدگی پروژه و نرخ‌های بازار ایران قیمت‌گذاری کنید.',
      'قرارداد نیاز است؟': 'بله، همیشه یک قرارداد کتبی داشته باشید تا از حقوق شما حمایت شود.',
      'نحوه مذاکره': 'ارزش افزوده خود را توضیح دهید و از تجربیات قبلی خود بگویید.'
    };
    
    for (String pattern in knowledgeBase.keys) {
      if (question.contains(pattern) || pattern.contains(question)) {
        return knowledgeBase[pattern];
      }
    }
    
    return null;
  }

  // تابع اصلی پردازش پروژه
  Map<String, dynamic> processProject({
    required String type,
    required int experienceLevel,
    required int complexity,
    required int deadline,
    required String description,
    required String paymentTerms,
    String? clientHistory,
    String? question,
  }) {
    double smartPrice = calculateSmartPrice(type, experienceLevel, complexity, deadline);
    var fraudRisk = detectFraudRisk(description, paymentTerms, clientHistory);
    var learningChallenge = generateLearningChallenge(type, experienceLevel);
    String? mentorAnswer = question != null ? findMentorAnswer(question) : null;
    
    return {
      'smartPrice': smartPrice,
      'fraudRisk': fraudRisk,
      'learningChallenge': learningChallenge,
      'mentorAnswer': mentorAnswer,
    };
  }
}

// نمونه استفاده
void main() {
  final aiSystem = CompactAISystem();
  
  print('=== سیستم هوش مصنوعی داخلی فشرده ===');
  print('نام: سیستم کمک فریلنسری ایران');
  print('حجم کد: کمتر از 500 خط');
  print('قابلیت آفلاین: بله');
  print('پشتیبانی فارسی: بله');
  
  // نمونه پردازش یک پروژه
  var result = aiSystem.processProject(
    type: 'web_development',
    experienceLevel: 3,
    complexity: 2,
    deadline: 14,
    description: 'سایت فروشگاهی فوری - کار تست لازم است',
    paymentTerms: 'پس‌پرداخت',
    clientHistory: 'new',
    question: 'چطور قیمت پروژه تعیین کنم؟',
  );
  
  print('\nنتایج:');
  print('قیمت پیشنهادی: ${result['smartPrice']} تومان');
  print('ریسک کلاهبرداری: ${result['fraudRisk']['riskLevel']}');
  print('چالش آموزشی: ${result['learningChallenge']?['title']}');
  print('پاسخ مربی: ${result['mentorAnswer']}');
}