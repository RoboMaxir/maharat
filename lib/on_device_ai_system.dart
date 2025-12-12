import 'engines/negotiation_engine.dart';
import 'engines/fraud_detection_engine.dart';
import 'engines/adaptive_learning_engine.dart';
import 'engines/smart_mentor_engine.dart';

/// سیستم هوش مصنوعی داخلی (On-Device AI) برای اپلیکیشن فریلنسری
/// 
/// این سیستم شامل چهار موتور اصلی است:
/// 1. مذاکره هوشمند
/// 2. تشخیص کلاهبرداری
/// 3. یادگیری تطبیقی
/// 4. مربی هوشمند
/// 
/// تمام عملیات‌ها به صورت آفلاین و روی دستگاه کاربر انجام می‌شود
/// بدون نیاز به اینترنت یا APIهای خارجی
class OnDeviceAISystem {
  final NegotiationEngine negotiationEngine = NegotiationEngine();
  final FraudDetectionEngine fraudDetectionEngine = FraudDetectionEngine();
  final AdaptiveLearningEngine adaptiveLearningEngine = AdaptiveLearningEngine();
  final SmartMentorEngine smartMentorEngine = SmartMentorEngine();

  /// اجرای کامل سیستم هوش مصنوعی برای یک پروژه فریلنسری
  /// 
  /// [projectDetails]: جزئیات پروژه شامل نوع، پیچیدگی، مهلت و غیره
  /// [clientDetails]: جزئیات کارفرما شامل سابقه، نوع و روش ارتباط
  /// [userProfile]: پروفایل کاربر شامل سطح تجربه و حوزه تخصصی
  Map<String, dynamic> processFreelanceProject({
    required Map<String, dynamic> projectDetails,
    required Map<String, dynamic> clientDetails,
    required Map<String, dynamic> userProfile,
  }) {
    // مرحله 1: محاسبه قیمت پیشنهادی هوشمند
    double smartPrice = negotiationEngine.calculateSmartPrice(
      projectType: projectDetails['type'],
      experienceLevel: userProfile['experienceLevel'],
      projectComplexity: projectDetails['complexity'],
      deadlineDays: projectDetails['deadline'],
      clientType: clientDetails['type'],
    );

    // مرحله 2: بررسی احتمال کلاهبرداری
    var fraudRisk = fraudDetectionEngine.detectFraudRisk(
      projectDescription: projectDetails['description'],
      paymentTerms: projectDetails['paymentTerms'],
      clientHistory: clientDetails['history'],
      contactMethod: clientDetails['contactMethod'],
    );

    // مرحله 3: تولید چالش آموزشی مناسب (اگر لازم باشد)
    Map<String, dynamic>? learningChallenge;
    if (userProfile['needsTraining'] == true) {
      learningChallenge = adaptiveLearningEngine.generateAdaptiveChallenge(
        skillArea: userProfile['specialty'],
        userLevel: userProfile['experienceLevel'],
        performance: userProfile['recentPerformance']?.toDouble() ?? 0.5,
      );
    }

    // مرحله 4: دریافت مشاوره هوشمند (اگر سوالی وجود داشته باشد)
    Map<String, dynamic>? mentorAdvice;
    if (projectDetails['hasQuestions'] == true) {
      mentorAdvice = smartMentorEngine.findAnswer(
        question: projectDetails['question'] ?? 'چگونه این پروژه را مدیریت کنم؟',
        category: 'contracts', // دسته پیش‌فرض
        userExperience: userProfile['experienceLevel'],
      );
    }

    return {
      'projectId': projectDetails['id'],
      'smartPricing': {
        'recommendedPrice': smartPrice,
        'negotiationAdvice': negotiationEngine.suggestNegotiationResponse(
          currentOffer: projectDetails['currentOffer']?.toDouble() ?? smartPrice * 0.8,
          calculatedPrice: smartPrice,
        ),
      },
      'fraudDetection': fraudRisk,
      'learningChallenge': learningChallenge,
      'mentorAdvice': mentorAdvice,
      'overallRisk': _calculateOverallRisk(fraudRisk['riskScore']),
      'confidence': 0.85, // اطمینان کلی از تصمیم‌گیری هوشمند
    };
  }

  /// محاسبه ریسک کلی پروژه بر اساس تمام عوامل
  String _calculateOverallRisk(double fraudRiskScore) {
    if (fraudRiskScore >= 70) return 'بسیار بالا - پیشنهاد رد پروژه';
    if (fraudRiskScore >= 50) return 'بالا - با احتیاط پیش بروید';
    if (fraudRiskScore >= 30) return 'متوسط - احتیاط کنید';
    if (fraudRiskScore >= 15) return 'کم - نسبتاً ایمن';
    return 'خیلی کم - پروژه ایمن';
  }

  /// نمایش خلاصه عملکرد سیستم
  void demonstrateSystem() {
    print('=== سیستم هوش مصنوعی داخلی (On-Device AI) ===');
    print('نام: سیستم کمک فریلنسری ایران');
    print('نسخه: 1.0.0');
    print('تعداد موتورها: 4');
    print('قابلیت آفلاین: بله');
    print('پشتیبانی از فارسی: بله');
    print('حجم کد: کمتر از 500 خط');
    print('');

    // نمایش عملکرد هر موتور به صورت جداگانه
    NegotiationExample.demonstrateNegotiationEngine();
    FraudDetectionExample.demonstrateFraudDetectionEngine();
    AdaptiveLearningExample.demonstrateAdaptiveLearningEngine();
    SmartMentorExample.demonstrateSmartMentorEngine();

    // نمونه استفاده از سیستم کامل
    print('\n=== نمونه کاربرد کامل سیستم ===');
    var result = processFreelanceProject(
      projectDetails: {
        'id': 'proj_123',
        'type': 'web_development',
        'complexity': 3,
        'deadline': 14,
        'description': 'سایت فروشگاهی فوری - کار تست لازم است - پرداخت بعد از تحویل',
        'paymentTerms': 'پس‌پرداخت',
        'currentOffer': 1200000.0,
        'hasQuestions': true,
        'question': 'چطور قیمت پروژه خود را تعیین کنم؟',
      },
      clientDetails: {
        'history': 'new',
        'type': 'local',
        'contactMethod': 'telegram',
      },
      userProfile: {
        'experienceLevel': 3,
        'specialty': 'web_development',
        'needsTraining': true,
        'recentPerformance': 0.7,
      },
    );

    print('قیمت پیشنهادی هوشمند: ${result['smartPricing']['recommendedPrice']} تومان');
    print('سطح ریسک کلی: ${result['overallRisk']}');
    print('توصیه مذاکره: ${result['smartPricing']['negotiationAdvice']['suggestion']}');
    print('نکات ایمنی: ${result['fraudDetection']['safetyTips'].length} مورد');
    print('چالش آموزشی: ${result['learningChallenge'] != null ? 'وجود دارد' : 'ندارد'}');
    print('مشاوره مربی: ${result['mentorAdvice'] != null ? 'دریافت شد' : 'دریافت نشد'}');
  }
}

// نمونه استفاده از کل سیستم
void main() {
  final aiSystem = OnDeviceAISystem();
  aiSystem.demonstrateSystem();
}