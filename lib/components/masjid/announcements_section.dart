import 'package:flutter/material.dart';
import 'package:islamiq/models/masjid.dart';
import 'package:islamiq/theme/app_theme.dart';

class AnnouncementsSection extends StatelessWidget {
  final List<Announcement> announcements;

  const AnnouncementsSection({Key? key, required this.announcements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.backgroundWhite,
        borderRadius: BorderRadius.circular(16),
        boxShadow: AppTheme.cardShadow,
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.accentGreen,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.campaign,
                  color: AppTheme.primaryGreen,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Announcements',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all announcements
                },
                child: Text(
                  'View All',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppTheme.primaryGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Announcements List
          if (announcements.isEmpty)
            _buildEmptyState()
          else
            ...announcements.take(3).map((announcement) => 
              _buildAnnouncementItem(announcement)
            ).toList(),
        ],
      ),
    );
  }

  Widget _buildAnnouncementItem(Announcement announcement) {
    final isImportant = announcement.isImportant;
    final isExpired = announcement.expiryDate?.isBefore(DateTime.now()) ?? false;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isImportant 
            ? AppTheme.primaryGreen.withOpacity(0.05)
            : AppTheme.backgroundLight,
        borderRadius: BorderRadius.circular(12),
        border: isImportant 
            ? Border.all(color: AppTheme.primaryGreen.withOpacity(0.2))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with category and date
          Row(
            children: [
              if (isImportant)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.priority_high, color: Colors.white, size: 12),
                      SizedBox(width: 4),
                      Text(
                        'Important',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              if (!isImportant)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.textMedium.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    announcement.category.toUpperCase(),
                    style: TextStyle(
                      color: AppTheme.textMedium,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              const Spacer(),
              Text(
                _formatDate(announcement.createdAt),
                style: TextStyle(
                  fontSize: 12,
                  color: AppTheme.textMedium.withOpacity(0.7),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 12),
          
          // Title
          Text(
            announcement.title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isImportant ? AppTheme.primaryGreen : AppTheme.textDark,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Description
          Text(
            announcement.description,
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textMedium,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          
          // Expiry notice
          if (announcement.expiryDate != null) ...[
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  isExpired ? Icons.schedule : Icons.schedule_outlined,
                  size: 14,
                  color: isExpired ? Colors.red : AppTheme.textMedium,
                ),
                const SizedBox(width: 4),
                Text(
                  isExpired 
                      ? 'Expired'
                      : 'Valid until ${_formatDate(announcement.expiryDate!)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isExpired ? Colors.red : AppTheme.textMedium,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.campaign_outlined,
            size: 48,
            color: AppTheme.textMedium.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No announcements yet',
            style: TextStyle(
              fontSize: 16,
              color: AppTheme.textMedium,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Check back later for updates from the masjid',
            style: TextStyle(
              fontSize: 14,
              color: AppTheme.textMedium.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}