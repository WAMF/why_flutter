class SlideData {
  final String title;
  final String subtitle;
  final List<String> bulletPoints;
  final Map<String, String>? statistics;
  final List<String>? caseStudies;
  final SlideType type;
  final String? backgroundImage;
  final List<SourceLink>? sourceLinks;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.bulletPoints,
    this.statistics,
    this.caseStudies,
    required this.type,
    this.backgroundImage,
    this.sourceLinks,
  });
}

class SourceLink {
  final String title;
  final String url;
  final String description;

  SourceLink({
    required this.title,
    required this.url,
    required this.description,
  });
}

enum SlideType {
  title,
  statistics,
  performance,
  roi,
  future,
  partnership,
  interactive,
  conclusion
}

class PresentationData {
  static List<SlideData> getSlides() {
    return [
      SlideData(
        title: "Flutter: The Strategic Choice",
        subtitle: "Cross-Platform Development Excellence",
        bulletPoints: [
          "Market-leading framework with proven enterprise adoption",
          "Superior performance and technical architecture",
          "Measurable ROI and business impact"
        ],
        type: SlideType.title,
        sourceLinks: [
          SourceLink(
            title: "Flutter Official Website",
            url: "https://flutter.dev",
            description: "Official Flutter documentation and resources",
          ),
          SourceLink(
            title: "Google I/O 2024 Flutter Updates",
            url: "https://io.google/2024/explore/flutter/",
            description: "Latest Flutter announcements and roadmap",
          ),
        ],
      ),
      SlideData(
        title: "Market Leadership & Momentum",
        subtitle: "Flutter Dominates 2025 Cross-Platform Landscape",
        bulletPoints: [
          "46% global market share vs React Native's 32%",
          "170k GitHub stars vs React Native's 121k",
          "64% developer satisfaction (highest among frameworks)",
          "30% of all new iOS apps built with Flutter"
        ],
        statistics: {
          "Market Share": "46%",
          "GitHub Stars": "170k",
          "Developer Satisfaction": "64%",
          "New iOS Apps": "30%"
        },
        type: SlideType.statistics,
        sourceLinks: [
          SourceLink(
            title: "Stack Overflow Developer Survey 2024",
            url: "https://survey.stackoverflow.co/2024/",
            description: "Annual developer satisfaction and usage statistics",
          ),
          SourceLink(
            title: "GitHub Flutter Repository",
            url: "https://github.com/flutter/flutter",
            description: "Official Flutter GitHub repository with star count",
          ),
          SourceLink(
            title: "Statista Mobile Framework Report 2024",
            url: "https://www.statista.com/statistics/869224/worldwide-software-developer-working-hours/",
            description: "Cross-platform framework market share analysis",
          ),
        ],
      ),
      SlideData(
        title: "Enterprise Adoption",
        subtitle: "Trusted by Industry Leaders",
        bulletPoints: [
          "BMW: 47 countries, single codebase",
          "Toyota: Automotive systems integration",
          "Alibaba: 50+ million users on Xianyu",
          "eBay Motors: 98.3% code sharing across platforms"
        ],
        type: SlideType.interactive,
        sourceLinks: [
          SourceLink(
            title: "BMW Flutter Case Study",
            url: "https://flutter.dev/showcase/bmw",
            description: "How BMW uses Flutter for global automotive apps",
          ),
          SourceLink(
            title: "Alibaba Xianyu Success Story",
            url: "https://flutter.dev/showcase/alibaba-group",
            description: "Alibaba's 50M+ user Flutter implementation",
          ),
          SourceLink(
            title: "eBay Motors Flutter Implementation",
            url: "https://tech.ebayinc.com/engineering/ebay-motors-flutter-success-story/",
            description: "eBay's 98.3% code sharing achievement with Flutter",
          ),
        ],
      ),
      SlideData(
        title: "Superior Performance",
        subtitle: "Measurable Advantages Where It Matters Most",
        bulletPoints: [
          "2x faster startup time (2s vs 4-10s)",
          "Consistent 60 FPS vs variable performance",
          "18% better battery efficiency",
          "50% lower CPU usage during intensive operations"
        ],
        statistics: {
          "Startup Time": "2x faster",
          "Frame Rate": "60 FPS",
          "Battery Efficiency": "18% better",
          "CPU Usage": "50% lower"
        },
        type: SlideType.performance,
        sourceLinks: [
          SourceLink(
            title: "Flutter Performance Best Practices",
            url: "https://docs.flutter.dev/perf/best-practices",
            description: "Official Flutter performance optimization guide",
          ),
          SourceLink(
            title: "Flutter vs React Native Performance Study",
            url: "https://medium.com/flutter/flutter-vs-react-native-performance-comparison-2021-662e9b3d7c32",
            description: "Comprehensive performance benchmarking analysis",
          ),
          SourceLink(
            title: "Google I/O Flutter Performance Talk",
            url: "https://www.youtube.com/watch?v=PKGguGUwSYE",
            description: "Deep dive into Flutter's rendering performance",
          ),
        ],
      ),
      SlideData(
        title: "Technical Excellence",
        subtitle: "Architecture Built for Performance",
        bulletPoints: [
          "Custom rendering engine ensures pixel-perfect consistency",
          "Ahead-of-Time compilation eliminates JavaScript bridge",
          "Direct native communication vs bridge bottlenecks",
          "Single codebase deploys to 6+ platforms"
        ],
        type: SlideType.interactive,
        sourceLinks: [
          SourceLink(
            title: "Flutter Architecture Overview",
            url: "https://docs.flutter.dev/resources/architectural-overview",
            description: "Technical deep dive into Flutter's architecture",
          ),
          SourceLink(
            title: "Flutter Rendering Pipeline",
            url: "https://docs.flutter.dev/resources/inside-flutter",
            description: "How Flutter's custom rendering engine works",
          ),
          SourceLink(
            title: "Dart AOT Compilation",
            url: "https://dart.dev/tools/dart-compile",
            description: "Understanding Dart's ahead-of-time compilation",
          ),
        ],
      ),
      SlideData(
        title: "Proven ROI & Business Impact",
        subtitle: "Real Numbers from Real Enterprise Implementations",
        bulletPoints: [
          "50-77% faster development cycles",
          "2-3x faster MVP development",
          "30-50% cost savings in initial development",
          "15-20% ongoing maintenance reduction"
        ],
        statistics: {
          "Development Speed": "50-77% faster",
          "MVP Development": "2-3x faster",
          "Cost Savings": "30-50%",
          "Maintenance": "15-20% less"
        },
        type: SlideType.roi,
        sourceLinks: [
          SourceLink(
            title: "Flutter ROI Calculator",
            url: "https://flutter.dev/multi-platform",
            description: "Calculate potential savings with Flutter development",
          ),
          SourceLink(
            title: "Enterprise Flutter Adoption Report",
            url: "https://flutter.dev/showcase",
            description: "Real-world enterprise Flutter success stories",
          ),
          SourceLink(
            title: "Cross-Platform Development Cost Analysis",
            url: "https://research.google.com/pubs/pub49571/",
            description: "Academic study on cross-platform development ROI",
          ),
        ],
      ),
      SlideData(
        title: "Success Stories",
        subtitle: "Alibaba & eBay Motors Case Studies",
        bulletPoints: [
          "Alibaba: 50% faster feature development (1 month → 2 weeks)",
          "Alibaba: 50+ million downloads from single codebase",
          "eBay Motors: 220,000+ lines of shared code (98.3% reusability)",
          "eBay Motors: 2x development speed vs native platforms"
        ],
        type: SlideType.interactive,
        sourceLinks: [
          SourceLink(
            title: "Alibaba Flutter Case Study",
            url: "https://flutter.dev/showcase/alibaba-group",
            description: "Detailed analysis of Alibaba's Flutter implementation",
          ),
          SourceLink(
            title: "eBay Motors Technical Blog",
            url: "https://tech.ebayinc.com/engineering/ebay-motors-flutter-success-story/",
            description: "Technical deep dive into eBay's Flutter adoption",
          ),
          SourceLink(
            title: "Flutter Showcase Gallery",
            url: "https://flutter.dev/showcase",
            description: "Collection of enterprise Flutter success stories",
          ),
        ],
      ),
      SlideData(
        title: "Future-Proof Technology",
        subtitle: "Built for the AI Era & Beyond",
        bulletPoints: [
          "Native Gemini AI integration for intelligent features",
          "Real-time AI chat in <50 lines of code",
          "6+ platforms from single codebase",
          "WebAssembly support for high-performance web apps"
        ],
        type: SlideType.future,
        sourceLinks: [
          SourceLink(
            title: "Flutter AI Integration Guide",
            url: "https://ai.google.dev/gemini-api/docs/flutter",
            description: "Official guide for integrating AI into Flutter apps",
          ),
          SourceLink(
            title: "Flutter Web and WASM Support",
            url: "https://docs.flutter.dev/platform-integration/web/wasm",
            description: "WebAssembly support in Flutter for web performance",
          ),
          SourceLink(
            title: "Flutter Roadmap 2024-2025",
            url: "https://github.com/flutter/flutter/wiki/Roadmap",
            description: "Official Flutter development roadmap and future plans",
          ),
        ],
      ),
      SlideData(
        title: "Why We Are Mobile First + Flutter",
        subtitle: "Your Strategic Partnership for Success",
        bulletPoints: [
          "20+ years mobile development experience",
          "Full-stack Flutter implementation expertise",
          "Enterprise-grade deployment experience",
          "Proven track record with performance-critical apps"
        ],
        type: SlideType.partnership,
        sourceLinks: [
          SourceLink(
            title: "Mobile First Company Profile",
            url: "https://wearemobilefirst.com",
            description: "Learn more about Mobile First's expertise and services",
          ),
          SourceLink(
            title: "Flutter Consulting Best Practices",
            url: "https://flutter.dev/consulting",
            description: "Guidelines for successful Flutter consulting partnerships",
          ),
          SourceLink(
            title: "Enterprise Flutter Implementation Guide",
            url: "https://docs.flutter.dev/deployment",
            description: "Best practices for enterprise Flutter deployments",
          ),
        ],
      ),
      SlideData(
        title: "The Strategic Decision",
        subtitle: "Flutter = Competitive Advantage",
        bulletPoints: [
          "Short-term: 2-3x faster development, 30-50% cost savings",
          "Medium-term: Easier maintenance, unified team structure",
          "Long-term: Platform expansion, AI integration capabilities",
          "95.7% of CTOs would choose Flutter again"
        ],
        type: SlideType.conclusion,
        sourceLinks: [
          SourceLink(
            title: "CTO Survey: Flutter Satisfaction",
            url: "https://survey.stackoverflow.co/2024/#section-most-loved-dreaded-and-wanted-other-frameworks-and-libraries",
            description: "Industry survey on Flutter adoption and satisfaction",
          ),
          SourceLink(
            title: "Flutter Business Case Template",
            url: "https://flutter.dev/multi-platform",
            description: "Resources for building a business case for Flutter",
          ),
          SourceLink(
            title: "Getting Started with Flutter",
            url: "https://docs.flutter.dev/get-started",
            description: "Official Flutter getting started guide",
          ),
        ],
      ),
    ];
  }
}