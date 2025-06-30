class SlideData {
  final String title;
  final String subtitle;
  final List<String> bulletPoints;
  final Map<String, String>? statistics;
  final List<String>? caseStudies;
  final SlideType type;
  final String? backgroundImage;

  SlideData({
    required this.title,
    required this.subtitle,
    required this.bulletPoints,
    this.statistics,
    this.caseStudies,
    required this.type,
    this.backgroundImage,
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
      ),
    ];
  }
}